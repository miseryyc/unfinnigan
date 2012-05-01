use warnings FATAL => qw( all );
our $VERSION = 0.0205;

# ----------------------------------------------------------------------------------------
package Finnigan::Scan::Profile;

my $MAX_DIST = 0.025; # kHz

sub new {
  my ($class, $buf, $layout) = @_;
  my $self = {};
  @{$self}{'first value', 'step', 'peak count', 'nbins'} = unpack 'd<d<VV', $buf;
  my $offset = 24; # ddVV

  my $chunk;
  foreach my $i (0 .. $self->{'peak count'} - 1) {
    $chunk = new Finnigan::Scan::ProfileChunk $buf, $offset, $layout;
    $offset += $chunk->{size};
    push @{$self->{chunks}}, $chunk;
  }

  return bless $self, $class;
}

sub set_converter {
  $_[0]->{converter} = $_[1];
}

sub set_inverse_converter {
  $_[0]->{"inverse converter"} = $_[1];
}

sub nchunks { # instead of the deprecated peak_count()
  $_[0]->{"peak count"};
}

sub peak_count { # deprecated
  $_[0]->{"peak count"};
}

sub bins {
  my ($self, $range, $add_zeroes) = @_;
  my @list;
  my $start = $self->{"first value"};
  my $step = $self->{step};
  unless ( $range ) {
    unless ( exists $self->{converter} ) {
      $range = [$start, $start + $self->{nbins} * $step];
    }
  }

  push @list, [$range->[0], 0] if $add_zeroes;
  my $last_bin_written = 0;

  my $shift = 0; # this is declared outside the chunk loop to allow
                 # writing the empty bin following the last chunk with
                 # the same amount of shift as in the last chunk

  foreach my $i ( 0 .. $self->{"peak count"} - 1 ) { # each chunk
    my $chunk = $self->{chunks}->[$i];
    my $first_bin = $chunk->{"first bin"};
    $shift = $chunk->{fudge} || 0;
    my $x = $start + $first_bin * $step;

    if ( $add_zeroes and $last_bin_written < $first_bin - 1) {
      # add an empty bin ahead of the chunk, unless there is no gap
      # between this and the previous chunk
      my $x0 = $x - $step;
      my $x_conv = exists $self->{converter} ? &{$self->{converter}}($x0) + $shift : $x0;
      push @list, [$x_conv, 0];
    }

    foreach my $j ( 0 .. $chunk->{nbins} - 1) {
      my $x_conv = exists $self->{converter} ? &{$self->{converter}}($x) + $shift : $x;
      $x += $step;
      if ( $range ) {
        if ( exists $self->{converter} ) {
          next unless $x_conv >= $range->[0] and $x_conv <= $range->[1];
        }
        else {
          # frequencies have the reverse order
          next unless $x_conv <= $range->[0] and $x_conv >= $range->[1];
        }
      }
      my $bin = $first_bin + $j;
      push @list, [$x_conv, $chunk->{signal}->[$j]];
      $last_bin_written = $first_bin + $j;
    }

    if ( $add_zeroes
         and
         $i < $self->{"peak count"} - 1
         and
         $last_bin_written < $self->{chunks}->[$i+1]->{"first bin"} - 1
       ) {
      # add an empty bin following the chunk, unless there is no gap
      # between this and the next chunk
      my $bin = $last_bin_written + 1;
      # $x has been incremented inside the chunk loop
      my $x_conv = exists $self->{converter} ? &{$self->{converter}}($x) + $shift: $x;
      push @list, [$x_conv, 0];
      $last_bin_written++;
    }
  }

  if ( $add_zeroes and $last_bin_written < $self->{nbins} - 1 ) {
    # add an empty bin following the last chunk, unless there is no gap
    # left between it and the end of the range ($self->nbins - 1)
    my $x = $start + ($last_bin_written + 1) * $step;
    my $x_conv = exists $self->{converter} ? &{$self->{converter}}($x) + $shift: $x;
    push @list, [$x_conv, 0];
    push @list, [$range->[1], 0] if $add_zeroes;
  }
  return \@list;
}

sub find_peak_intensity {
  # Finds the nearest peak in the profile for a given query value.
  # One possible use is to look up the precursor ion intensity, since
  # it is not stored as a separate item anywhere in the data file.
  my ($self, $query) = @_;
  my $raw_query = &{$self->{"inverse converter"}}($query);

  # find the closest chunk
  my ($nearest_chunk, $dist) = $self->find_chunk($raw_query);
  if (not defined $dist or $dist > $MAX_DIST) { # undefind $dist means we're outside the full range of peaks in the scan
    say STDERR "$self->{'dependent scan number'}: could not find a profile peak in parent scan $self->{'scan number'} within ${MAX_DIST} kHz of the target frequency $raw_query (M/z $query)";
    return 0;
  }

  my @chunk_ix = ($nearest_chunk);
  $i = $nearest_chunk;
  while ( $i < $self->{"peak count"} - 1 and $self->chunk_dist($i, $i++) <= $MAX_DIST ) { # kHz
    push @chunk_ix, $i;
  }
  $i = $nearest_chunk;
  while ( $i > 0 and $self->chunk_dist($i, $i--) <= $MAX_DIST ) { # kHz
    push @chunk_ix, $i;
  }

  return (sort {$b <=> $a} map {$self->chunk_max($_)} @chunk_ix)[0]; # max. intensity
}

sub chunk_dist {
  # find the gap distance between the chunks
  my ($self, $i, $j) = @_;
  my ($chunk_i, $chunk_j) = ($self->{chunks}->[$i], $self->{chunks}->[$j]);
  my $start = $self->{"first value"};
  my $step = $self->{step};
  my $min_i = $start + ($chunk_i->{"first bin"} - 1) * $step;
  my $max_i = $min_i + $chunk_i->{nbins} * $step;
  my $min_j = $start + ($chunk_j->{"first bin"} - 1) * $step;
  my $max_j = $min_j + $chunk_j->{nbins} * $step;
  my $dist = (sort {$a <=> $b}
        (
         abs($min_i - $min_j),
         abs($min_i - $max_j),
         abs($max_i - $min_j),
         abs($max_i - $max_j)
        )
       )[0];
  return $dist;
}

sub chunk_max {
  my ($self, $num) = @_;
  my $chunk = $self->{chunks}->[$num];
  my $max = 0;
  foreach my $i ( 0 .. $chunk->{nbins} - 1) {
    my $intensity = $chunk->{signal}->[$i];
    $max = $intensity if $intensity > $max;
  }
  return $max;
}

sub find_chunk {
  # Use binary search to find a pair of profile chunks
  # in the (sorted) chunk list surrounding the probe value

  my ( $self, $value) = @_;
  my $chunks = $self->{chunks};
  my $first_value = $self->{"first value"};
  my $step = $self->{step};
  my ( $lower, $upper, $low_ix, $high_ix, $cur );
  my $safety_count = 15;
  my $last_match = [undef, 100000];
  my $dist;

  ( $upper, $lower ) = ( $first_value, $first_value + $step * $self->{nbins} ) ;
  if ( $value < $lower - $MAX_DIST or $value > $upper + $MAX_DIST) {
    return (undef, undef);
  }
  else {
    ( $low_ix, $high_ix ) = ( 0, $self->{"peak count"} - 1 );
    while ( $low_ix < $high_ix ) {
      die "broken find_chunk algorithm" unless $safety_count--;
      $cur = int ( ( $low_ix + $high_ix ) / 2 );
      my $chunk = $chunks->[$cur];
      $upper = $first_value + $chunk->{"first bin"} * $step;
      $lower = $upper + $chunk->{nbins} * $step;
      # say STDERR "    testing: $cur [$lower .. $upper] against $value in [$low_ix .. $high_ix]";
      if ( $value >= $lower and $value <= $upper ) {
        # say STDERR "      direct hit";
        return ($cur, 0);
      }
      if ( $value > $upper ) {
        $dist = (sort {$a <=> $b} (abs($value - $lower), abs($value - $upper)))[0];
        $last_match = [$cur, $dist] if $dist < $last_match->[1];
        # say STDERR "      distance = $dist, shifting up";
        $high_ix = $cur;
      }
      if ( $value < $lower ) {
        $dist = (sort {$a <=> $b} (abs($value - $lower), abs($value - $upper)))[0];
        $last_match = [$cur, $dist] if $dist < $last_match->[1];
        # say STDERR "      distance = $dist; shifting down";
        $low_ix = $cur + 1;
      }
      # say STDERR "The remainder: $low_ix, $high_ix";
    }
    # say STDERR "The final remainder: $low_ix, $high_ix";
  }

  if ( $low_ix == $high_ix ) {
    # this is one of possibly two closest chunks, with no direct hits found
    my $chunk = $chunks->[$low_ix];
    $upper = $first_value + $chunk->{"first bin"} * $step;
    $lower = $upper + $chunk->{nbins} * $step;
    my $dist = (sort {$a <=> $b} (abs($value - $lower), abs($value - $upper)))[0];

    my ($closest_chunk, $min_dist) = ($low_ix, $dist);
    if ( $dist > $last_match->[1] ) {
      ($closest_chunk, $min_dist) = @$last_match;
    }
    # say STDERR "      no direct hit; closest chunk is $closest_chunk; distance between $value and [$lower, $upper] is $min_dist";
    return ($closest_chunk, $min_dist);
  }

  die "unexpected condition";
}

#----------------------------------------------------------------------------------------
package Finnigan::Scan;

use strict;
use warnings;

use Finnigan;

sub decode {
  my ($class, $stream) = @_;

  my $self = {
	      addr => tell $stream
	     };
  my $buf;
  my $nbytes;
  my $bytes_to_read;
  my $current_addr;

  $self->{header} = Finnigan::PacketHeader->decode($stream);
  $self->{size} = $self->{header}->{size};
  my $header_data = $self->{header}->{data};

  $bytes_to_read = 4 * $header_data->{"profile size"}->{value};
  $nbytes = CORE::read $stream, $self->{"raw profile"}, $bytes_to_read;
  $nbytes == $bytes_to_read
    or die "could not read all $bytes_to_read bytes of scan profile at " . ($self->{addr} + $self->{size});
  $self->{size} += $nbytes;

  $bytes_to_read = 4 * $header_data->{"peak list size"}->{value};
  $nbytes = CORE::read $stream, $self->{"raw centroids"}, $bytes_to_read;
  $nbytes == $bytes_to_read
    or die "could not read all $bytes_to_read bytes of scan profile at " . ($self->{addr} + $self->{size});
  $self->{size} += $nbytes;

  # skip peak descriptors and the unknown streams
  $self->{size} += 4 * (
                        $header_data->{"descriptor list size"}->{value} +
                        $header_data->{"size of unknown stream"}->{value} +
                        $header_data->{"size of triplet stream"}->{value}
                       );
  seek $stream, $self->{addr} + $self->{size}, 0;

  return bless $self, $class;
}

sub header {
  return shift->{header};
}

sub profile {
  new Finnigan::Scan::Profile $_[0]->{"raw profile"}, $_[0]->{header}->{data}->{layout}->{value};
}

sub centroids {
  new Finnigan::Scan::CentroidList $_[0]->{"raw centroids"};
}

# end Finnigan::Scan::Profile
# ----------------------------------------------------------------------------------------
package Finnigan::Scan::ProfileChunk;

sub new {
  my ($class, $buf, $offset, $layout) = @_;
  my $self = {};
  if ( $layout > 0 ) {
    @{$self}{'first bin', 'nbins', 'fudge'} = unpack "x${offset} VVf<", $buf;
    $self->{size} = 12;
  }
  else {
    @{$self}{'first bin', 'nbins'} = unpack "x${offset} VV", $buf;
    $self->{size} = 8;
  }
  $offset += $self->{size};

  @{$self->{signal}} = unpack "x${offset} f<$self->{nbins}", $buf;
  $self->{size} += 4 * $self->{nbins};

  return bless $self, $class;
}

#----------------------------------------------------------------------------------------
package Finnigan::Scan::CentroidList;

sub new {
  my ($class, $buf) = @_;
  my $self = {count => unpack 'V', $buf};
  my $offset = 4; # V

  my $chunk;
  foreach my $i (0 .. $self->{count} - 1) {
    push @{$self->{peaks}}, [unpack "x${offset} f<f<", $buf];
    $offset += 8;
  }

  return bless $self, $class;
}

sub count {
  shift->{count};
}

sub list {
  shift->{peaks};
}

1;

__END__
=head1 NAME

Finnigan::Scan -- a lightweight scan data decoder

=head1 SUBMODULES

Finnigan::Scan::Profile

Finnigan::Scan::ProfileChunk

Finnigan::Scan::CentroidList

=head1 SYNOPSIS

  my $scan = Finnigan::Scan->decode(\*INPUT);
  say $scan->header->profile_size;
  say $scan->header->peak_list_size;

  my $profile = $scan->profile;
  $profile->set_converter( $converter ); # from ScanEvent
  my $bins = $profile->bins;
  my ($mz, $abundance) = @{$bins->[0]} # data in the first bin

  my $c = $scan->centroids
  say $c->count;

  say $c->list->[0]->[0]; # the first centroid M/z
  say $c->list->[0]->[1]; # abundance

=head1 DESCRIPTION

This decoder reads the entire ScanDataPacket, discarding the location
and type meta-data. It is a more efficient alternative to the
full-featured combination decoders using the Finnigan::Profile,
Finnigan::Peaks and Finnigan::Peak modules.

=head2 METHODS

=over 4

=item decode

The constructor method

=item header

Get the Finnigan::PacketHeader object. It is the only full-featured
decoder object used in this module; since it occurs only once in each
scan, there is no significant performance loss.

=item profile

Get the Finingan::Scan::Profile object containing the profile, if it exists

=item centroids

Get the Finnigan::Scan::CentroidList object containing the peak centroid list, if it exists

=back

=head1 SEE ALSO

Finnigan::Scan: (lightweight decoder object)

Finnigan::PacketHeader (decoder object)

Finnigan::Scan::Profile (lightweight decoder object)

Finnigan::Scan::CentroidList (lightweight decoder object)


=head1 NAME

Finnigan::Scan::Profile -- a lightweight decoder for Finnigan scan profiles

=head1 SYNOPSIS
  use Finnigan;

  my $scan = Finnigan::Scan->decode(\*INPUT);
  my $profile = $scan->profile;
  $profile->set_converter( $converter ); # from ScanEvent
  my $bins = $profile->bins;
  my ($mz, $abundance) = @{$bins->[0]} # data in the first bin

=head1 DESCRIPTION

Finningan::Scan::Profile is a lightweight decoder for the Profile
structure. It does not save the location and type information for the
elements it decodes, nor does it provide element-level accessor
methods. That makes it fast, at the cost of a slight reduction in
convenience of access to the data.

It does not do file reads either, decoding part of the stream of
profile chunks it receives as a constructor argument from the
caller. Its full-featured equivalent, Finnigan::Profile, does a file
read for every data element down to a single integer of floating-point
number, which makes it very slow.

Finnigan::Scan::Profile is good for use in production-level
programs that need extensive debugging. In a situation that calls for
detailed exploration (e.g., a new file format), better use
Finnigan::Peaks, which has an equivalent interface.

Every scan done in the profile mode has a profile, which is either a
time-domain signal or a frequency spectrum accumulated in
histogram-like bins.

A profile can be either raw or filtered. Filtered profiles are sparse;
they consist of separate data chunks. Each chunk consists of a
contiguous range of bins containing the above-threshold signal. The
bins whose values fall below a cerain threshold are simply discarded,
leaving gaps in the profile -- the reason for the ProfileChunk
structure to exist.

One special case is raw profile, which preserves all data. Since there
are no gaps in a raw profile, it is represented by a single chunk
covering the entire range of bins, so the same container structure is
suitable for complete profiles, as well as for sparse ones.

The bins store the signal intensity, and the bin co-ordinates are
typically the frequencies of Fourier-transformed signal. Since the
bins are equally spaced in the frequency domain, only the first bin
frequency is stored in each profile header. The bin width is common
for all bins and it is also stored in the same header. With these
data, it is possible to calculate the bin values based on the bin
indices.

The programs reading these data must convert the frequencies into the
M/z values using the conversion function specific to the type of
analyser used to acquire the signal. The calibrated coefficients for
this convesion function are stored in the ScanEvent structure (one
instance of this structure exists for every scan).

The B<bins> method of Finnigan::Scan::Profile returns the converted bins,
optionally filling the gaps with zeroes.

=head2 METHODS

=over 4

=item new($buffer, $layout)

The constructor method

=item nchunks

Get the number of chunks in the profile

=item set_converter($func_ref)

Set the converter function (f → M/z)

=item set_inverse_converter($func_ref)

Set the inverse converter function (M/z → f)

=item bins

Get the reference to an array of bin values. Each array element
contains an (M/z, abundance) pair. This method calls the converter set
by the set_converter method.

=item find_peak_intensity($query_mz)

Get the nearest peak in the profile for a given query value. The
search will fail if nothing is found within 0.025 kHz of the target
value (the parameter set internally as $MAX_DIST). This method
supports the search for precursor intensity in uf-mzxml.

=back

=head1 SEE ALSO 

Profile (structure)

ProfileChunk (structure)

Finnigan::Scan::ProfileChunk (lightweight decoder)

Finnigan::PacketHeader (decoder object)

Finnigan::Profile (full-featured decoder)

Finnigan::Scan (lightweight decoder)

ScanEvent (structure containing conversion coefficients)

Finnigan::ScanEvent (decoder object)

L<uf-scan> (command-line tool)

=head1 NAME

Finnigan::Scan::ProfileChunk -- a lightweight decoder for a single ProfileChunk structure

=head1 SYNOPSIS

  use Finnigan;

  my $chunk = new Finnigan::Scan::ProfileChunk($buffer, $offset, $packet_header->layout);
  $offset += $chunk->{size};

  say $chunk->{"first bin"} ;
  say $chunk->{fudge};
  my $nbins = $chunk->{nbins};
  foreach my $i ( 0 .. $nbins - 1) {
    say $chunk->signal->[$i];
  }

=head1 DESCRIPTION

Finningan::Scan::ProfileChunk is a lightweight decoder for the
ProfileChunk structure, a segment of a Profile. It does not save the
location and type information for the individual list elements, nor
does it provide element-level accessor methods. That makes it fast, at
the cost of a slight reduction in convenience of access to the data.

It does not do file reads either, decoding part of the stream of
profile chunks it receives as a constructor argument from the
caller. Its full-featured equivalent, Finnigan::Peaks, does a file
read for every data element down to a single integer of floating-point
number, which makes it very slow.

Finnigan::Scan::ProfileChunk is good for use in production-level
programs that need extensive debugging. In a situation that calls for
detailed exploration (e.g., a new file format), better use
Finnigan::Peaks, which has an equivalent interface.

Every scan done in the profile mode has a profile, which is either a
time-domain signal or a frequency spectrum accumulated in
histogram-like bins.

A profile can be either raw or filtered. Filtered profiles are sparse;
they consist of separate data chunks. Each chunk consists of a
contiguous range of bins containing the above-threshold signal. The
bins whose values fall below a cerain threshold are simply discarded,
leaving gaps in the profile -- the reason for the ProfileChunk
structure to exist.

One special case is raw profile, which preserves all data. Since there
are no gaps in a raw profile, it is represented by a single chunk
covering the entire range of bins, so the same container structure is
suitable for complete profiles, as well as for sparse ones.

The bins store the signal intensity, and the bin co-ordinates are
typically the frequencies of Fourier-transformed signal. Since the
bins are equally spaced in the frequency domain, only the first bin
frequency is stored in each profile header. The bin width is common
for all bins and it is also stored in the same header. With these
data, it is possible to calculate the bin values based on the bin
indices.

Each ProfileChunk structure stores the first bin index, the number of
bins, and a list of bin intensities. Additionally, in some layouts, it
stores a small floating-point value that most probably represents the
instrument drift relative to its calibrated value; this "fudge" value
is added to the result of the the frequency to M/z conversion. The
chunk layout (the presence or absence of the fudge value) is
determined by the layout flag in PacketHeader.

=head2 METHODS

=over 4

=item new($buffer, $offset, $layout)

The constructor method

This module defines no accessor method because doing so would defeat its goal of being a fast decoder.

=back



=head1 NAME

Finnigan::Scan::CentroidList -- a lightweight decoder for PeakList, the list of peak centroids

=head1 SYNOPSIS

  use Finnigan;

  my $c = Finnigan::Scan::CentroidList->new($buffer);
  say $c->count;
  say $c->list->[0]->[0]; # M/z
  say $c->list->[0]->[1]; # abundance

=head1 DESCRIPTION

This simple and lightweight decoder for the PeakList structure does
not save the location and type information for the individual list
elements, nor does it provide element-level accessor methods. That
makes it fast, at the cost of a slight reduction in convenience of
access to the data.

It does not do file reads either, decoding the stream of
floating-point numbers it receives as a constructor argument into an
array of (M/z, abundance) pairs. Its full-featured equivalent,
Finnigan::Peaks, does a file read for each peak, which makes it very
slow.

It is good for use in production-level programs that do not need
extensive debugging. In a situation that calls for detailed
exploration (e.g., a new file format), better use Finnigan::Peaks,
which has an equivalent interface.

=head2 METHODS

=over 4

=item new($buffer)

The constructor method

=item count

Get the number of peaks in the list

=item list

Get the reference to an array containing the pairs of (M/z, abundance) values of each centroided peak

=back

=head1 SEE ALSO

Finnigan::Scan: (lightweight decoder object)

Finnigan::PacketHeader (decoder object)


=head1 AUTHOR

Gene Selkov, E<lt>selkovjr@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Gene Selkov

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut

