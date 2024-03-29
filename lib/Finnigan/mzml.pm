#!/usr/bin/env perl

use strict;
use warnings FATAL => qw( all );
use feature qw/state say/;
use 5.010;

use Data::UUID; 
use Digest::SHA1;
use File::Basename qw(basename);
use Finnigan;
use Getopt::Declare;
use MIME::Base64;
use Scalar::Util qw(looks_like_number);
use Tie::IxHash;
use XML::Generator;

my $ug = new Data::UUID;
my $guid = $ug->create_hex();

my %thermoInstId = (
                    'Accela PDA' => 'MS:1000623',
                    'DELTA plusAdvantage' => 'MS:1000153',
                    'DELTAplusXP' => 'MS:1000154',
                    'DFS' => 'MS:1000640',
                    'DSQ II' => 'MS:1000641',
                    'DSQ' => 'MS:1000634',
                    'Element 2' => 'MS:1000646',
                    'Element GD' => 'MS:1000647',
                    'Element XR' => 'MS:1000645',
                    'Exactive' => 'MS:1000649',
                    'GC IsoLink' => 'MS:1000648',
                    'GC Quantum' => 'MS:1000558',
                    'ITQ 1100' => 'MS:1000637',
                    'ITQ 700' => 'MS:1000635',
                    'ITQ 900' => 'MS:1000636',
                    'LCQ Advantage' => 'MS:1000167',
                    'LCQ Classic' => 'MS:1000168',
                    'LCQ Deca XP Plus' => 'MS:1000169',
                    'LCQ Deca' => 'MS:1000554',
                    'LCQ Fleet' => 'MS:1000578',
                    'LTQ FT Ultra' => 'MS:1000557',
                    'LTQ FT' => 'MS:1000448',
                    'LTQ Orbitrap Discovery' => 'MS:1000555',
                    'LTQ Orbitrap Velos' => 'MS:1001742',
                    'LTQ Orbitrap XL ETD' => 'MS:1000639',
                    'LTQ Orbitrap XL' => 'MS:1000556',
                    'LTQ Orbitrap' => 'MS:1000449',
                    'LTQ Velos ETD' => 'MS:1000856',
                    'LTQ Velos' => 'MS:1000855',
                    'LTQ XL ETD' => 'MS:1000638',
                    'LTQ XL' => 'MS:1000854',
                    'LTQ' => 'MS:1000447',
                    'LXQ' => 'MS:1000450',
                    'MALDI LTQ Orbitrap' => 'MS:1000643',
                    'MALDI LTQ XL' => 'MS:1000642',
                    'PolarisQ' => 'MS:1000185',
                    'Surveyor MSQ' => 'MS:1000193',
                    'Surveyor PDA' => 'MS:1000622',
                    'TEMPUS TOF' => 'MS:1000196',
                    'TRACE DSQ' => 'MS:1000197',
                    'TRITON' => 'MS:1000198',
                    'TSQ Quantum Access' => 'MS:1000644',
                    'TSQ Quantum Ultra AM' => 'MS:1000743',
                    'TSQ Quantum Ultra' => 'MS:1000751',
                    'TSQ Quantum' => 'MS:1000199',
                    'TSQ Vantage' => 'MS:1001510',
                    'neptune' => 'MS:1000179',
);

my %thermoInstDef = (
                    'Accela PDA' => "Accela PDA",
                    'DELTA plusAdvantage' => "ThermoFinnigan DELTA plusAdvantage MS",
                    'DELTAplusXP' => "ThermoFinnigan DELTAplusXP MS",
                    'DFS' => "Thermo Scientific DFS HR GC-MS",
                    'DSQ II' => "Thermo Scientific DSQ II GC-MS",
                    'DSQ' => "ThermoFinnigan DSQ GC-MS",
                    'Element 2' => "Thermo Scientific Element 2 HR-ICP-MS",
                    'Element GD' => "Thermo Scientific Element GD Glow Discharge MS",
                    'Element XR' => "Thermo Scientific Element XR HR-ICP-MS",
                    'Exactive' => "Thermo Scientific Exactive MS",
                    'GC IsoLink' => "Thermo Scientific GC IsoLink Isotope Ratio MS",
                    'GC Quantum' => "GC Quantum",
                    'ITQ 1100' => "Thermo Scientific ITQ 1100 GC-MS",
                    'ITQ 700' => "Thermo Scientific ITQ 700 GC-MS",
                    'ITQ 900' => "Thermo Scientific ITQ 900 GC-MS",
                    'LCQ Advantage' => "ThermoFinnigan LCQ Advantage MS",
                    'LCQ Classic' => "ThermoFinnigan LCQ Classic MS",
                    'LCQ Deca XP Plus' => "ThermoFinnigan LCQ Deca XP Plus MS",
                    'LCQ Deca' => "ThermoFinnigan LCQ Deca",
                    'LCQ Fleet' => "LCQ Fleet",
                    'LTQ FT Ultra' => "LTQ FT Ultra",
                    'LTQ FT' => "Finnigan LTQ FT MS",
                    'LTQ Orbitrap Discovery' => "LTQ Orbitrap Discovery",
                    'LTQ Orbitrap Velos' => "Finnigan LTQ Orbitrap Velos MS",
                    'LTQ Orbitrap XL ETD' => "Thermo Scientific LTQ Orbitrap XL MS with ETD",
                    'LTQ Orbitrap XL' => "LTQ Orbitrap XL",
                    'LTQ Orbitrap' => "Finnigan LTQ Orbitrap MS",
                    'LTQ Velos ETD' => "Thermo Scientific LTQ Velos MS with ETD",
                    'LTQ Velos' => "Thermo Scientific LTQ Velos MS",
                    'LTQ XL ETD' => "Thermo Scientific LTQ XL MS with ETD",
                    'LTQ XL' => "Thermo Scientific LTQ XL MS",
                    'LTQ' => "Finnigan LTQ MS",
                    'LXQ' => "Finnigan LXQ MS",
                    'MALDI LTQ Orbitrap' => "Thermo Scientific MALDI LTQ Orbitrap MS",
                    'MALDI LTQ XL' => "Thermo Scientific MALDI LTQ XL MS",
                    'PolarisQ' => "ThermoFinnigan PolarisQ MS",
                    'Surveyor MSQ' => "ThermoFinnigan Surveyor MSQ MS",
                    'Surveyor PDA' => "Surveyor PDA",
                    'TEMPUS TOF' => "ThermoFinnigan TEMPUS TOF MS",
                    'TRACE DSQ' => "ThermoFinnigan TRACE DSQ MS",
                    'TRITON' => "ThermoFinnigan TRITON MS",
                    'TSQ Quantum Access' => "Thermo Scientific TSQ Quantum Access MS",
                    'TSQ Quantum Ultra AM' => "Thermo Scientific TSQ Quantum Ultra AM",
                    'TSQ Quantum Ultra' => "Thermo Scientific TSQ Quantum Ultra",
                    'TSQ Quantum' => "ThermoFinnigan TSQ Quantum MS",
                    'TSQ Vantage' => "TSQ Vantage",
                    'neptune' => "ThermoFinnigan NEPTUNE MS",
                   );

my %accession = (
  'electrospray ionization' => 'MS:1000073',
  'electrospray inlet' => 'MS:1000057',
  'nanoelectrospray' => 'MS:1000398',
  'nanospray inlet' => 'MS:1000485',
  'orbitrap' => 'MS:1000484',
  'inductive detector' => 'MS:1000624',
  'radial ejection linear ion trap' => 'MS:1000083',
  'electron multiplier' => 'MS:1000253',

  'MS1 spectrum' => 'MS:1000579',
  'MSn spectrum' => 'MS:1000580',
  'ms level' => 'MS:1000511',
  'positive scan' => 'MS:1000130',
  'centroid spectrum' => 'MS:1000127',
  'profile spectrum' => 'MS:1000128',
  'base peak m/z' => 'MS:1000504',
  'base peak intensity' => 'MS:1000505',
  'total ion current' => 'MS:1000285',
  'lowest observed m/z' => 'MS:1000528',
  'highest observed m/z' => 'MS:1000527',
  'no combination' => 'MS:1000795',
  'scan start time' => 'MS:1000016',
  'filter string' => 'MS:1000512',
  'preset scan configuration' => 'MS:1000616',
  'ion injection time' => 'MS:1000927',
  'scan window lower limit' => 'MS:1000501',
  'scan window upper limit' => 'MS:1000500',
  'isolation window target m/z' => 'MS:1000827',
  'isolation window lower offset' => 'MS:1000828',
  'isolation window upper offset' => 'MS:1000829',
  'selected ion m/z' => 'MS:1000744',
  'charge state' => 'MS:1000041',
  'peak intensity' => 'MS:1000042',
  'collision-induced dissociation' => 'MS:1000133',
  'surface-induced dissociation' => 'MS:1000439',
  'electron capture dissociation' => 'MS:1000250',
  'electron transfer dissociation' => 'MS:1000598',
  'photodissociation' => 'MS:1000435',
  'multiphoton dissociation' => 'MS:1000227',
  'infrared multiphoton dissociation' => 'MS:1000262',
  'collision energy' => 'MS:1000045',

  'm/z' => 'MS:1000040',
  'minute' => 'UO:0000031',
  'millisecond' => 'UO:0000028',
  'number of counts' => 'MS:1000131',
  'electronvolt' => 'UO:0000266',
);

my %ms_unit = (
  'peak intensity' => 'number of counts',
  'base peak intensity' => 'number of counts',
  'base peak m/z' => 'm/z',
  'lowest observed m/z' => 'm/z',
  'highest observed m/z' => 'm/z',
  'scan window lower limit' => 'm/z',
  'scan window upper limit' => 'm/z',
  'isolation window target m/z' => 'm/z',
  'isolation window lower offset' => 'm/z',
  'isolation window upper offset' => 'm/z',
  'selected ion m/z' => 'm/z',
);

my %uo_unit = (
  'scan start time' => 'minute',
  'ion injection time' => 'millisecond',
  'collision energy' => 'electronvolt',
);

my %components = (
  'LTQ' => [
    [
      ['source', ['nanoelectrospray', 'nanospray inlet']],
      ['analyzer', ['radial ejection linear ion trap']],
      ['detector', ['electron multiplier']]
    ],
  ],
  'LTQ Orbitrap' => [
    [
      ['source', ['nanoelectrospray', 'nanospray inlet']],
      ['analyzer', ['orbitrap']],
      ['detector', ['inductive detector']]
    ],
    [
      ['source', ['nanoelectrospray', 'nanospray inlet']],
      ['analyzer', ['radial ejection linear ion trap']],
      ['detector', ['electron multiplier']]
    ],
  ],
  'LTQ Orbitrap XL' => [
    [
      ['source', ['electrospray ionization', 'electrospray inlet']],
      ['analyzer', ['orbitrap']],
      ['detector', ['inductive detector']]
    ],
    [
      ['source', ['electrospray ionization', 'electrospray inlet']],
      ['analyzer', ['radial ejection linear ion trap']],
      ['detector', ['electron multiplier']]
    ],
  ]
);


# test case:
#  uf-mzml -c -r 350 .. 352 20070522_NH_Orbi2_HelaEpo_05.RAW > test.xml

my $args = new Getopt::Declare q{
  [strict]
  -a[ctivationMethod] <symbol>		specify ion activation method [CID by default]
  -c[entroids]				prefer peak centroids to scan profiles, if available
  -r[ange] <from:0+n> .. <to:0+n>	write only scans with numbers between <from> and <to>
  -q[uiet]			        suppress the instrument error messages
  -u[nencoded]				render the data unencoded (in decimal encoding)
  -s[tructure]				output just the XML structure of the file (without the data)
  <file>				input file [required]
}
  or exit(-1);

my $file = $args->{"<file>"};
-e $file or die "file '$file' does not exist";
-f $file or die "'$file' is not a plain file";
-s $file or die "'$file' has zero size";

my $basename = basename($file, qw/.raw .RAW/);

# -----------------------------------------------------------------------------

$Finnigan::activationMethod = lc $args->{-a}{"<symbol>"} if exists $args->{-a};

open INPUT, "<$file" or die "can't open '$file': $!";
binmode INPUT;

my $sha1 = new Digest::SHA1;
$sha1->addfile(\*INPUT);
my $digest = $sha1->hexdigest;
seek INPUT, 0, 0; # rewind

# reset the digest generator to work with our output
$sha1 = new Digest::SHA1;

my $header = Finnigan::FileHeader->decode(\*INPUT);
my $VERSION = $header->version;
my $seq_row = Finnigan::SeqRow->decode(\*INPUT, $VERSION);
my $cas_info = Finnigan::CASInfo->decode(\*INPUT);
my $rfi = Finnigan::RawFileInfo->decode(\*INPUT, $VERSION);

# my $method_file = Finnigan::MethodFile->decode(\*INPUT, $VERSION);
# my %translate = @{$method_file->translation_table};

my $data_addr = $rfi->preamble->data_addr;
my $run_header_addr = $rfi->preamble->run_header_addr;

# fast-forward to RunHeader
seek INPUT, $run_header_addr, 0;
my $run_header = Finnigan::RunHeader->decode(\*INPUT, $VERSION);
my $scan_index_addr = $run_header->scan_index_addr;
my $trailer_addr = $run_header->trailer_addr;
my $params_addr = $run_header->params_addr;

# InstID follows immediately
my $inst = Finnigan::InstID->decode(\*INPUT);

# ---------------------------------------------------------------------
# fast-forward to ScanIndex
seek INPUT, $scan_index_addr, 0;

my %scan_index;
# this code is not fool-proof and is not finished! It assumes that
# there are exactly as many entries in ScanIndex as would fit
# between $first_scan and $last_scan. In other words, the internal
# indices and links are not checked.
my $first_scan = $run_header->sample_info->first_scan;
my $last_scan = $run_header->sample_info->last_scan;

# get the first entry
my $entry = Finnigan::ScanIndexEntry->decode(\*INPUT, $VERSION);
my $size = $entry->size;
seek INPUT, $scan_index_addr, 0; # step back for simplicity; we just
                                 # need to know the record size at
                                 # this point, to be able to skip records
my $from = exists $args->{-r} ? $args->{-r}{"<from>"} : $first_scan;
my $to = exists $args->{-r} ? $args->{-r}{"<to>"} : $last_scan;
die "inverted range: [$from .. $to]" if $from > $to;

if ( $from > $first_scan) {
  # skip these entries
  seek INPUT, $scan_index_addr + ($from - $first_scan)*$size, 0;
}
foreach my $i ($from - 1 .. $to - 1) {
  $scan_index{$i} = Finnigan::ScanIndexEntry->decode(\*INPUT, $VERSION)->values;
}


# ---------------------------------------------------------------------
# Now go read the trailer. Because the trailer records are of variable
# size, they are not directly addressable and all of them must be
# read, up to the highest number in the range.
seek INPUT, $trailer_addr, 0;

# read the number of ScanEvent records in the file
my $rec;
my $bytes_to_read = 4;
my $nbytes = read INPUT, $rec, $bytes_to_read;
$nbytes == $bytes_to_read
  or die "could not read all $bytes_to_read bytes of the trailer scan events count at $trailer_addr";
my $trailer_length = unpack 'V', $rec;

my %scan_event;
my %ms_power;
foreach my $i ( 0 .. $trailer_length - 1) {
  my $n = $i + 1;
  my $e = Finnigan::ScanEvent->decode(\*INPUT, $VERSION)->purge_unused_data;
  next if $n < $from;
  if ($n == $from and $e->preamble->dependent) {
    say STDERR "Range error: cannot form valid mzML starting with the dependent scan $n";
    exit -1;
  }

  $scan_event{$i} = $e;
  $ms_power{$e->preamble->ms_power}++;
  last if $n == $to;
}

# say STDERR "memory used: " . get_stat_info()->{vsize}/1024/1024 . " Mb";

# ---------------------------------------------------------------------
# Now read the ScanParameters stream. Its records have variable size
# and are not directly addressable, so all of them must be read, up to
# the highest number in the range.

# First, in order to reach the ScanParameters header, the error
# log and the scan hierarchy must be read.

# error log
my $error_log_addr = $run_header->error_log_addr;
seek INPUT, $error_log_addr, 0;

# read the number of ErrorLog records
my $error_log_length = Finnigan::Decoder->read(\*INPUT, ['length' => ['V', 'UInt32']])->{data}->{length}->{value};
foreach my $i ( 0 .. $error_log_length - 1) {
  my $e = Finnigan::Error->decode(\*INPUT);
  unless ( exists $args->{'-q'} ) {
    say STDERR "Error: (time = " . $e->time . "): " . $e->message;
  }
}

# read the scan even hierarchy
my $scanEventTemplate;
my $nsegs = Finnigan::Decoder->read(\*INPUT, ['nsegs' => ['V', 'UInt32']])->{data}->{nsegs}->{value};
foreach my $i ( 0 .. $nsegs - 1) {
  my $n = Finnigan::Decoder->read(\*INPUT, ['n' => ['V', 'UInt32']])->{data}->{n}->{value};
  foreach my $j ( 0 .. $n - 1) {
    $scanEventTemplate->{$i}->{$j} = Finnigan::ScanEventTemplate->decode(\*INPUT, $VERSION);
  }
}

# now the file pointer is at the start of GenericDataHeader for ScanParameters
my $params_header = Finnigan::GenericDataHeader->decode(\*INPUT);

# With the header on hand, skip to the ScanParameters stream and grab
# a few values for each scan (just the required ones, to reduce memory use)
seek INPUT, $params_addr, 0;

my $param;
foreach my $i ( $first_scan - 1 .. $last_scan - 1) {
  my $n = $i + 1;
  my $p = Finnigan::ScanParameters->decode(\*INPUT, $params_header->field_templates);
  next if $n < $from;
  my $charge = $p->charge_state;
  $param->{charge_state}->{$i} = $charge if $charge;
  $param->{injection_time}->{$i} = $p->injection_time;
  $param->{monoisotopic_mz}->{$i} = $p->monoisotopic_mz;
  $param->{scan_event_number}->{$i} = $p->scan_event;
  last if $n == $to;
}

# say STDERR "memory used: " . get_stat_info()->{vsize}/1024/1024 . " Mb";

# prepare the TIC chromatogram for output using the data in ScanIndex
my $length = $to - $from + 1;
my $time_encoded_length = ($length * 8 + 2 - ($length * 8 + 2) % 3) / 3 * 4;
my $tic_encoded_length = ($length * 4 + 2 - ($length * 4 + 2) % 3) / 3 * 4;

my $encoded_time = '';
my $encoded_tic = '';
my @time;
my @tic;
unless ( exists $args->{-s}) {
  foreach ( sort {$a <=> $b} keys %scan_index ) {
    # don't select; the "chromatogram" they want is a mix
    # if ( $scan_event{$_}->preamble->ms_power == 1 ) { 
    push @time, $scan_index{$_}->{'start time'};
    push @tic, $scan_index{$_}->{'total current'};
    #}
  }
  if (exists $args->{-u}) {
    $encoded_time = join("\n", '', @time) . "\n              ";
    $encoded_tic = join("\n", '', @tic) . "\n              ";
  }
  else { # encode
    my $buf = '';
    foreach ( @time ) {
      $buf .= pack("d<", $_);
    }
    $encoded_time = encode_base64($buf, '');
    $buf = '';
    foreach ( @tic ) {
      $buf .= pack("f<", $_);
    }
    $encoded_tic = encode_base64($buf, '');
  }
}

#------------------------------------------------------------------------------------------
# This is a reasonably good point to start generating the output. We
# know everything about the data, but haven't started reading the scan
# data itself

my $parent_scan_data; # for looking up the precursor ion for each of
                      # the dependent MS2 scans

my %scan_data;

my $x = XML::Generator->new(
                            pretty => 2,
                            # conformance => 'strict',
                            namespace => ['http://psi.hupo.org/ms/mzml'],
                           );


# XML-related stuff ----------------------------------------------------
tie my %cvAttr1, 'Tie::IxHash';
%cvAttr1 = (
            id => 'MS',
            fullName => 'Proteomics Standards Initiative Mass Spectrometry Ontology',
            version => '3.4.1',
            URI => 'http://psidev.cvs.sourceforge.net/*checkout*/psidev/psi/psi-ms/mzML/controlledVocabulary/psi-ms.obo'
           );

tie my %cvAttr2, 'Tie::IxHash';
%cvAttr2 = (
            id => 'UO',
            fullName => 'Unit Ontology',
            version => '18:03:2011',
            URI => 'http://obo.cvs.sourceforge.net/*checkout*/obo/obo/ontology/phenotype/unit.obo'
           );

# File content description ---------------------------------------------
tie my %fileContentAttr1, 'Tie::IxHash';
%fileContentAttr1 = (
                     cvRef => 'MS',
                     accession => 'MS:1000579',
                     name => 'MS1 spectrum',
                     value => '',
                   );
tie my %fileContentAttr2, 'Tie::IxHash';
%fileContentAttr2 = (
                     cvRef => 'MS',
                     accession => 'MS:1000580',
                     name => 'MSn spectrum',
                     value => '',
                   );

# Source File list ------------------------------------------------------
tie my %sourceFileAttr, 'Tie::IxHash';
my @path = split m{[\\/]}, $seq_row->file_name;
my $name = pop @path;
my $path = $seq_row->path || join "/", @path;
%sourceFileAttr = (
                   id => 'RAW1',
                   name => $name,
                   location => "file:///$path"
                  );

tie my %sourceFileAttr1, 'Tie::IxHash';
%sourceFileAttr1 = (
                    cvRef => 'MS',
                    accession => 'MS:1000768',
                    name => 'Thermo nativeID format',
                    value => ''
                   );

tie my %sourceFileAttr2, 'Tie::IxHash';
%sourceFileAttr2 = (
                    cvRef => 'MS',
                    accession => 'MS:1000563',
                    name => 'Thermo RAW file',
                    value => ''
                   );

tie my %sourceFileAttr3, 'Tie::IxHash';
%sourceFileAttr3 = (
                    cvRef => 'MS',
                    accession => 'MS:1000569',
                    name => 'SHA-1',
                    value => $digest
                   );

# InstID (referenceableParamGroupList) -------------------------------------
tie my %instModelCvAttr, 'Tie::IxHash';
my $model = decode_string($inst->model);
%instModelCvAttr = (
                    cvRef => 'MS',
                    accession => $thermoInstId{$model} || 'MS:0000000',
                    name => $model,
                    value => ''
                   );

tie my %instSerialNoCvAttr, 'Tie::IxHash';
%instSerialNoCvAttr = (
                       cvRef => 'MS',
                       accession => 'MS:1000529',
                       name => 'instrument serial number',
                       value => decode_string($inst->serial_number)
                      );



# Acquisition Software ------------------------------------------
tie my %softwareAttr1, 'Tie::IxHash';
%softwareAttr1 = (
                    id => 'Xcalibur', # What elese? It does not name itself in the file.
                    version => decode_string($inst->software_version),
                   );

tie my %softwareCvAttr1, 'Tie::IxHash';
%softwareCvAttr1 = (
                     cvRef => 'MS',
                     accession => 'MS:1000532',
                     name => 'Xcalibur',
                     value => ''
                    );

# Conversion Software -------------------------------------------
tie my %softwareAttr2, 'Tie::IxHash';
%softwareAttr2 = (
                    id => basename $0,
                    version => $Finnigan::VERSION
                   );

tie my %softwareCvAttr2, 'Tie::IxHash';
%softwareCvAttr2 = (
                     cvRef => 'MS',
                     accession => 'MS:0000000',
                     name => 'Unfinnigan',
                     value => ''
                    );

# Instrument Configuration ------------------------------------------

my %translatedComponent;
my $i = 1;
foreach my $component ( @{$components{$model}} ) {
  foreach my $subcomponent (@$component) {
    my ($type, $features) = @$subcomponent;
    foreach my $feature (@$features) {
      tie my %featureAttr, 'Tie::IxHash';
      %featureAttr = (
                      cvRef => 'MS',
                      accession => $accession{$feature},
                      name => $feature,
                      value => '',
                     );
      $translatedComponent{$i}->{$type}->{$feature} = \%featureAttr;
    }
  }
  $i++;
}

# Processing method ------------------------------------------
tie my %processingMethodAttr, 'Tie::IxHash';
%processingMethodAttr = (
                         order => 0,
                         softwareRef => 'uf-mzml'
                        );

tie my %processingMethodCvAttr, 'Tie::IxHash';
%processingMethodCvAttr = (
                    cvRef => 'MS',
                    accession => 'MS:1000544',
                    name => 'Conversion to mzML',
                    value => ''
                   );



# Run -----------------------------------------------------------
tie my %runAttr, 'Tie::IxHash';
%runAttr = (
            id => $guid,
            defaultInstrumentConfigurationRef => 'IC1',
            startTimeStamp => $rfi->preamble->xmlTimestamp,
            defaultSourceFileRef => 'RAW1'
           );

# Spectrum list -------------------------------------------------
tie my %spectrumListAttr, 'Tie::IxHash';
%spectrumListAttr = (
                     count => $to - $from + 1,
                     defaultDataProcessingRef => 'mzml-conversion',
                    );

tie my %msIonisationAttr, 'Tie::IxHash';
%msIonisationAttr = (
              category => 'msIonisation',
              value => $scan_event{$from - 1}->preamble->ionization(decode => 1), # not knowing better;
                                                 # it can probably be found in the method file
             );

tie my %msAnalyzerAttr, 'Tie::IxHash';
%msAnalyzerAttr = (
              category => 'msMassAnalyzer',
              value => $scan_event{$from - 1}->preamble->analyzer(decode => 1), # not knowing better;
                                                 # it can probably be found in the method file
             );

tie my %msDetectorAttr, 'Tie::IxHash';
%msDetectorAttr = (
              category => 'msDetector',
              value => $scan_event{$from - 1}->preamble->detector(decode => 1), # not knowing better;
                                                 # it can probably be found in the method file
             );

tie my %dataProcessingAttr, 'Tie::IxHash';
if ( exists $args->{-c} ) {
  $dataProcessingAttr{centroided}++;
}

tie my %convSoftwareAttr, 'Tie::IxHash';
%convSoftwareAttr = (
                     type => 'conversion',
                     name => 'unfinnigan',
                     version => $Finnigan::VERSION,
                    );

tie my %indexedXmlDecl, 'Tie::IxHash';
%indexedXmlDecl = (
                   'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
                   'xsi:schemaLocation' => 'http://psi.hupo.org/ms/mzml http://psidev.info/files/ms/mzML/xsd/mzML1.1.1_idx.xsd'
                  );

tie my %xmlDecl, 'Tie::IxHash';
%xmlDecl = (
            'xmlns' => 'http://psi.hupo.org/ms/mzml',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => 'http://psi.hupo.org/ms/mzml http://psidev.info/files/ms/mzML/xsd/mzML1.1.0.xsd',
            id => $basename,
            version => '1.1.0'
           );

tie my %chromatogramListAttr, 'Tie::IxHash';
%chromatogramListAttr = (
                         'count' => 1,
                         defaultDataProcessingRef => 'mzml-conversion',
                        );

tie my %chromatogramAttr, 'Tie::IxHash';
%chromatogramAttr = (
            'index' => 0,
            'id' => 'TIC',
            'defaultArrayLength' => $to - $from + 1
           );

tie my %chromatogramCvAttr, 'Tie::IxHash';
%chromatogramCvAttr = (
                     cvRef => 'MS',
                     accession => 'MS:1000235',
                     name => 'total ion current chromatogram',
                     value => ''
                    );

tie my %binaryDataArrayCvAttr1, 'Tie::IxHash';
%binaryDataArrayCvAttr1 = (
                           cvRef => 'MS',
                           accession => 'MS:1000523',
                           name => '64-bit float',
                           value => ''
                          );

tie my %binaryDataArrayCvAttr2, 'Tie::IxHash';
%binaryDataArrayCvAttr2 = (
                           cvRef => 'MS',
                           accession => 'MS:1000576',
                           name => 'no compression',
                           value => ''
                          );

tie my %binaryDataArrayCvAttr3, 'Tie::IxHash';
%binaryDataArrayCvAttr3 = (
                           cvRef => 'MS',
                           accession => 'MS:1000514',
                           name => 'm/z array',
                           value => '',
                           unitCvRef => 'MS',
                           unitAccession => 'MS:1000040',
                           unitName => 'm/z'
                          );

tie my %binaryDataArrayCvAttr4, 'Tie::IxHash';
%binaryDataArrayCvAttr4 = (
                           cvRef => 'MS',
                           accession => 'MS:1000521',
                           name => '32-bit float',
                           value => ''
                          );

tie my %binaryDataArrayCvAttr5, 'Tie::IxHash';
%binaryDataArrayCvAttr5 = (
                           cvRef => 'MS',
                           accession => 'MS:1000515',
                           name => 'intensity array',
                           value => '',
                           unitCvRef => 'MS',
                           unitAccession => 'MS:1000131',
                           unitName => 'number of counts'
                          );

tie my %binaryDataArrayCvAttr6, 'Tie::IxHash';
%binaryDataArrayCvAttr6 = (
                           cvRef => 'MS',
                           accession => 'MS:1000595',
                           name => 'time array',
                           value => '',
                           unitCvRef => 'UO',
                           unitAccession => 'UO:0000031',
                           unitName => 'minute'
                          );

my $spectrumIndex = 0;
my $xml = $x->indexedmzML(
  ['http://psi.hupo.org/ms/mzml'],
  \%indexedXmlDecl,
  $x->mzML(
    ['http://psi.hupo.org/ms/mzml'],
    \%xmlDecl,
    $x->cvList({count => 2},
      $x->cv(\%cvAttr1),
      $x->cv(\%cvAttr2)
    ),
    $x->fileDescription(
      $x->fileContent(
        map {$x->cvParam($_->[0])} grep {$_->[1]} (
         [\%fileContentAttr1, $ms_power{'1'}],
         [\%fileContentAttr2, (grep {$_ ne '1'} keys %ms_power)[0]] # there are other powers besides 1
        )
      ),
      $x->sourceFileList({count => 1},
        $x->sourceFile(\%sourceFileAttr,
          $x->cvParam(\%sourceFileAttr1),
          $x->cvParam(\%sourceFileAttr2),
          $x->cvParam(\%sourceFileAttr3)
        )
      )
    ),
    $x->referenceableParamGroupList({count => 1},
      $x->referenceableParamGroup({
        id => 'CommonInstrumentParams'},
        $x->cvParam(\%instModelCvAttr),
        $x->cvParam(\%instSerialNoCvAttr),
      )
    ),
    $x->softwareList({count => 2},
      $x->software(\%softwareAttr1,
        $x->cvParam(\%softwareCvAttr1)
      ),
      $x->software(\%softwareAttr2,
        $x->cvParam(\%softwareCvAttr2)
      )
    ),
    $x->instrumentConfigurationList({count => scalar keys %translatedComponent},
      map {
        my $n = $_;
        my $ordinal = 1;
        $x->instrumentConfiguration({id => "IC$n"},
          $x->referenceableParamGroupRef({ref => 'CommonInstrumentParams'}),
          $x->componentList({count => scalar keys %{$translatedComponent{$n}}},
            map {
              my $subcomponent = $_;
              my $type = $subcomponent->[0];
              $x->$type({order => $ordinal++},
                map {
                  $x->cvParam($translatedComponent{$n}->{$type}->{$_})
                } @{$subcomponent->[1]} # features
              );
            } @{$components{$model}->[$n-1]}
          ),
          $x->softwareRef({ref => 'Xcalibur'})
        );
      } sort {$a <=> $b} keys %translatedComponent
    ),

    $x->dataProcessingList({count => 1},
      $x->dataProcessing({id => 'mzml-conversion'},
        $x->processingMethod(
          \%processingMethodAttr,
          $x->cvParam(\%processingMethodCvAttr)
        )
      )
    ),

    $x->run(\%runAttr,
      $x->spectrumList(
        \%spectrumListAttr,
        $x->cut('------------')
      ),
      $x->chromatogramList(
        \%chromatogramListAttr,
        $x->chromatogram(
          \%chromatogramAttr,
          $x->cvParam(\%chromatogramCvAttr),
          $x->binaryDataArrayList({count => 2},
            $x->binaryDataArray({encodedLength => $time_encoded_length},
              $x->cvParam(\%binaryDataArrayCvAttr1), # 64-bit float
              $x->cvParam(\%binaryDataArrayCvAttr2), # no compression
              $x->cvParam(\%binaryDataArrayCvAttr6), # time array
              $x->binary('encoded_time_placeholder')
            ), # $x->binaryDataArray
            $x->binaryDataArray({encodedLength => $tic_encoded_length},
              $x->cvParam(\%binaryDataArrayCvAttr4), # 32-bit float
              $x->cvParam(\%binaryDataArrayCvAttr2), # no compression
              $x->cvParam(\%binaryDataArrayCvAttr5), # intensity array
              $x->binary('encoded_tic_placeholder')
            ) # $x->binaryDataArray
          ) # $x->binaryDataArrayList
        ) # $x->chromatogram
      ) # $x->chromatogramList
    ) # $x->run
  ), # $x->mzML
  $x->indexList({count => 2},
    $x->index({name => 'spectrum'},
      $x->spectrumOffset
    ),
    $x->index({name => 'chromatogram'},
      $x->offset({idRef => 'TIC'}, 'Chromatogram Offset')
    )
  ),
  $x->indexListOffset('Index List Offset'),
  $x->fileChecksum('fileChecksumValue')
); # $x->indexedmzML

my ($head, $tail) = split '<cut>------------</cut>', "$xml";

#my $decl = qq(<?xml version="1.0" encoding="UTF-8"?>\n);
my $decl = qq(<?xml version="1.0" encoding="ISO-8859-1"?>\n);
print $decl;
$sha1->add($decl);

# put each element on its own line
$head =~ s/\"\n\s+/" /sg;
$head =~ s/\n\s+$/\n/s;
print $head;
$sha1->add($head);

my @xml_spectrum_offset;
my @xml_spectrum_id;

foreach my $n ( $from .. $to ) {
  my $i = $n - 1;
  my $chunk_no = $n - $from;

  my $scanData = read_scan($n, $args, \%scan_index, \%scan_event, exists $args->{-c});

  push @xml_spectrum_offset, 8 + tell STDOUT; # each <spectrum> tag is indented by 8
  push @xml_spectrum_id, "controllerType=" . $scanData->{controllerType} . " controllerNumber=" . $scanData->{controllerNumber} . " scan=$n";
  tie my %spectrumAttr, 'Tie::IxHash';  %spectrumAttr = (
                   index => $spectrumIndex++,
                   id => $xml_spectrum_id[-1],
                   defaultArrayLength => $scanData->{length}
                  );

  
  $x = XML::Generator->new(pretty => 2);
  $xml = $x->spectrum(
    \%spectrumAttr,
    (map {
      $x->cvParam(cvAttributesFor($_, $scanData, 'spectrum_param')),
    } @{$scanData->{spectrum_param_keys}}), # the enclosing parens are
          # needed to prevent map from concatenating its target list with
          # the list that follows

    $x->scanList(
      {count => 1},
      (map {
        $x->cvParam(cvAttributesFor($_, $scanData, 'scanlist_param')),
      } @{$scanData->{scanlist_param_keys}}),

      $x->scan({ instrumentConfigurationRef => 
                 $scanData->{ms_level} == 1 ? undef # the first component is implied by default
                 : (scalar keys %translatedComponent > 1 ? "IC$scanData->{ms_level}" : undef) },
        (map {
          $x->cvParam(cvAttributesFor($_, $scanData, 'scan_param')),
        } @{$scanData->{scan_param_keys}}),
        (map {
          $x->userParam($scanData->{user_param_attr}->{$_})
        } @{$scanData->{user_param_keys}}),
        $x->scanWindowList(
          {count => 1},
          $x->scanWindow(
            (map {
              $x->cvParam(cvAttributesFor($_, $scanData, 'scanwindow_param')),
            } @{$scanData->{scanwindow_param_keys}}),
          ) # $x->scanWindow
        ) # $x->scanWindowList
      ) # $x->scan
    ), # $x->scanList

    (map {
      $x->precursorList({count => scalar @{$scanData->{precursor_list}}},
        (map {
          my $precursor = $_;
          $x->precursor({
                         spectrumRef => "controllerType="
                                        . $parent_scan_data->{'controller type'}
                                        . " controllerNumber="
                                        . $parent_scan_data->{'controller number'}
                                        . " scan="
                                        . $parent_scan_data->{'scan number'}
                        },
            $x->isolationWindow(
              (map {
                $x->cvParam(cvAttributesFor($_, $precursor, 'isolation_window_param')),
              } @{$scanData->{isolation_window_param_keys}})
            ),
            $x->selectedIonList({count => scalar @{$precursor->{selected_ion_list}}},
              (map {
                my $list_item = $_;
                $x->selectedIon(
                  (map {
                    $x->cvParam(cvAttributesFor($_, $list_item, 'selected_ion_param')),
                  } @{$scanData->{selected_ion_param_keys}})
                )
              } @{$precursor->{selected_ion_list}})
            ),
            $x->activation(
              (map {
                $x->cvParam(cvAttributesFor($_, $precursor, 'activation_param')),
              } @{$precursor->{activation_param_keys}})
            ),
          )
        } @{$scanData->{precursor_list}})
      )
    } grep {exists $scanData->{$_}} qw/precursor_list/),

    $x->binaryDataArrayList({count => 2},
      $x->binaryDataArray({encodedLength => $scanData->{mz_encoded_length}},
        $x->cvParam(\%binaryDataArrayCvAttr1), # 64-bit float
        $x->cvParam(\%binaryDataArrayCvAttr2), # no compression
        $x->cvParam(\%binaryDataArrayCvAttr3), # m/z array
        # $x->binary($scanData->{encoded_mz}) # not a good idea: XML::Generator chokes on large data
        $x->binary('encoded_mz_placeholder')
      ), # $x->binaryDataArray
      $x->binaryDataArray({encodedLength => $scanData->{signal_encoded_length}},
        $x->cvParam(\%binaryDataArrayCvAttr4), # 32-bit float
        $x->cvParam(\%binaryDataArrayCvAttr2), # no compression
        $x->cvParam(\%binaryDataArrayCvAttr5), # intensity array
        # $x->binary($scanData->{encoded_intensity}) # not a good idea: XML::Generator chokes on large data
        $x->binary('encoded_intensity_placeholder')
      ) # $x->binaryDataArray
    ) # $x->binaryDataArrayList
  ); # $x->spectrum (parent)

  # put each element on its own line
  $xml =~ s/\"\n\s+/" /sg;
  $xml =~ s/\n\s+$//s;

  # insert data
  $xml =~ s/(encoded_(mz|intensity))_placeholder/$scanData->{$1}/g;

  # indent to match the parent element
  $xml =~ s/\n(?!\d)/\n        /sg;
  $xml = "        " . $xml . ($n == $to ? '' : "\n");
  $sha1->add($xml);
  print $xml;
}

# put each element on its own line
$tail =~ s/\"\n\s+/" /sg;
$tail =~ s/\n\s+$//s;

# insert data
$tail =~ s/encoded_time_placeholder/$encoded_time/;
$tail =~ s/encoded_tic_placeholder/$encoded_tic/;

my $current_pos = tell STDOUT;
my $chromatogram_offset = $current_pos + index($tail, '<chromatogram ');
my $index_list_offset = $current_pos + index($tail, '<indexList ');
my $offsets = join "\n      ", map {
  '<offset idRef="' . $xml_spectrum_id[$_ - 1] . '">' . $xml_spectrum_offset[$_ - 1] . '</offset>'
} $from .. $to;

$tail =~ s{<spectrumOffset />}{$offsets};
$tail =~ s{Chromatogram Offset}{$chromatogram_offset};
$tail =~ s{Index List Offset}{$index_list_offset};

my ($tail_head, $tail_tail) = split 'fileChecksumValue', $tail;
$sha1->add($tail_head);
print $tail_head;

say $sha1->hexdigest . $tail_tail;


sub decode_string {
  my $buf = shift;
  $buf =~ s/\x00//g;
  return $buf;
}

sub read_scan {
  my ($n, $args, $scan_index, $scan_event, $centroids_requested) = @_;
  my $i = $n-1;

  my $et = $scanEventTemplate->{$scan_index->{$i}->{'scan segment'}}->{$scan_index->{$i}->{'scan event'}};

  seek INPUT, $data_addr + $scan_index->{$i}->{offset}, 0;

  my $scan = Finnigan::Scan->decode( \*INPUT );
  my $ph = $scan->header;
  my $profile;
  $profile = $scan->profile if $ph->profile_size;
  if ( $profile ) {
    $profile->set_converter($scan_event->{$i}->converter);
    $profile->set_inverse_converter($scan_event->{$i}->inverse_converter);
  }
  my $peaks;
  $peaks = $scan->centroids if $ph->peak_list_size;
  my $ms_power = $scan_event->{$i}->preamble->ms_power;
  my $dependent = $scan_event->{$i}->preamble->dependent;
  if ( not $dependent ) {
    $parent_scan_data = $profile ? $profile : $peaks;
    $parent_scan_data->{type} = $profile ? 'profile' : 'centroid';
    $parent_scan_data->{'scan number'} = $n;
    $parent_scan_data->{'controller type'} = 0; # (fudge!) $et->controllerType;
    $parent_scan_data->{'controller number'} = 1; # (fudge!) $et->controllerNumber;
  }

  my $length;
  my $data_type;
  my $data;
  print STDERR "$n: ";
  if ( $profile ) {
    if ( $peaks ) {
      if ( $centroids_requested ) {
        # prefer centroids to the profile
        say STDERR "profile + centroids; centroids requested";
        $length = $peaks->count;
        if ( $length ) {
          $data = $peaks->list;
          $data_type = 'centroids';
        }
        else {
          $data_type = 'none';
        }
      }
      else {
        # ignore centroids
        say STDERR "profile + centroids; defaulting to profile";
        if ( $profile->nchunks > 1) {
          $data = $profile->bins(4); # add four-bin bookends
        }
        else {
          $data = $profile->bins;
        }
        $length = scalar @$data;
        $data_type = 'profile';
      }
    }
    else {
      # just get the profile, regardless of what was requested, because
      # there are no called peaks
      say STDERR "profile only";
      if ( $profile->nchunks > 1) {
        $data = $profile->bins(4); # add four-bin bookends
      }
      else {
        $data = $profile->bins;
      }
      $length = scalar @$data;
      $data_type = 'profile';
    }
  }
  elsif ( $peaks ) {
    # this scan only has centroids
    say STDERR "centroids only";
    $length = $peaks->count;
    $data = $peaks->list;
    $data_type = 'centroids';
  }
  else {
    $data_type = 'none';
  }

  # Base64 = (Bytes + 2 - ((Bytes + 2) MOD 3)) / 3 * 4
  my $mz_encoded_length = ($length * 8 + 2 - ($length * 8 + 2) % 3) / 3 * 4;
  my $signal_encoded_length = ($length * 4 + 2 - ($length * 4 + 2) % 3) / 3 * 4;

  my $encoded_mz = '';
  my $encoded_intensity = '';
  unless ( $data_type eq 'none' or exists $args->{-s}) {
    my @mz;
    my @intensity;
    foreach ( @$data ) {
      push @mz, $_->[0];
      push @intensity, $_->[1];
    }
    if (exists $args->{-u}) {
      $encoded_mz = join("\n", '', @mz) . "\n      ";
      $encoded_intensity = join("\n", '', @intensity) . "\n      ";
    }
    else { # encode
      my $buf = '';
      foreach ( @mz ) {
        $buf .= pack("d<", $_);
      }
      $encoded_mz = encode_base64($buf, '');
      $buf = '';
      foreach ( @intensity ) {
        $buf .= pack("f<", $_);
      }
      $encoded_intensity = encode_base64($buf, '');
    }
  }

  my %spectrum_param;
  my @spectrum_param_keys = (
                    'ms level',
                    'positive scan',
                    'negative scan',
                    'unknown (any) polarity scan',
                    'centroid spectrum',
                    'profile spectrum',
                    'base peak m/z',
                    'base peak intensity',
                    'total ion current',
                    'lowest observed m/z',
                    'highest observed m/z',
                   );

  $spectrum_param{'ms level'} = $ms_power;
  $spectrum_param{'negative scan'} = '' if $scan_event->{$i}->preamble->polarity == 0;
  $spectrum_param{'positive scan'} = '' if $scan_event->{$i}->preamble->polarity == 1;
  $spectrum_param{'unknown (any) polarity'} = '' if $scan_event->{$i}->preamble->polarity == 2;
  $spectrum_param{'profile spectrum'} = '' if $data_type eq 'profile';
  $spectrum_param{'centroid spectrum'} = '' if $data_type eq 'centroids';
  $spectrum_param{'base peak m/z'} = $scan_index->{$i}->{"base mz"};
  $spectrum_param{'base peak intensity'} = $scan_index->{$i}->{"base intensity"};
  $spectrum_param{'total ion current'} = $scan_index->{$i}->{"total current"};

  if ($data_type eq 'profile' ) {
    $spectrum_param{'lowest observed m/z'} = &{$profile->{converter}}(
      $profile->{'first value'} + $profile->{step}
    ) + ($profile->{chunks}->[0]->{'fudge'} || 0); # according to msconvert
    $spectrum_param{'highest observed m/z'} = &{$profile->{converter}}(
      $profile->{'first value'} + $profile->{step} * $profile->{nbins}
    ); # according to msconvert
  }
  elsif ($data_type eq 'centroids' ) {
    $spectrum_param{'lowest observed m/z'} = $peaks->list->[0]->[0];
    $spectrum_param{'highest observed m/z'} = $peaks->list->[-1]->[0];
  }
  else {
    $spectrum_param{'lowest observed m/z'} = 0;
    $spectrum_param{'highest observed m/z'} = 0;
  }

  my %scanlist_param;
  my @scanlist_param_keys = (
                             'no combination',
                            );
  $scanlist_param{'no combination'} = ''; # this means no other spectra were combined to produce this one

  my %scan_param;
  my @scan_param_keys = (
                         'scan start time',
                         'filter string',
                         'preset scan configuration',
                         'ion injection time',
                        );
  $scan_param{'scan start time'} = $scan_index->{$i}->{'start time'};
  $scan_param{'filter string'} = "$scan_event->{$i}";
  $scan_param{'preset scan configuration'} = $param->{scan_event_number}->{$i}; # using the param version because it starts at 1
  $scan_param{'ion injection time'} = $param->{injection_time}->{$i};

  my %scanwindow_param;
  my @scanwindow_param_keys = (
                               'scan window lower limit',
                               'scan window upper limit',
                              );
  $scanwindow_param{'scan window lower limit'} = $scan_index->{$i}->{"low mz"};
  $scanwindow_param{'scan window upper limit'} = $scan_index->{$i}->{"high mz"};

  if ( $ms_power > 1 ) {
    unshift @spectrum_param_keys, 'MSn spectrum';
    $spectrum_param{'MSn spectrum'} = '';

    $parent_scan_data->{"dependent scan number"} = $n;

    my @precursors;
    my @isolation_window_param_keys = (
                                       'isolation window target m/z',
                                       'isolation window lower offset',
                                       'isolation window upper offset'
                                      );
    my @selected_ion_param_keys = $param->{charge_state}->{$i} ? (
                                                       'selected ion m/z',
                                                       'charge state',
                                                       'peak intensity'
                                                      )
                                                    :
                                                      (
                                                       'selected ion m/z',
                                                       'peak intensity'
                                                      );
    
    my @activation_param_keys = (
                                'collision-induced dissociation',
                                'surface-induced dissociation',
                                'electron capture dissociation',
                                'electron transfer dissociation',
                                'photodissociation',
                                'multiphoton dissociation',
                                'infrared multiphoton dissociation',
                                'collision energy',
                               );

    foreach my $reaction ( @{$scan_event{$i}->precursors}) {
      push @precursors, {
                         isolation_window_param => {
                           'isolation window target m/z' => sprintf("%.2f", $reaction->precursor), # this is a fudge
                           'isolation window lower offset' => 1, # fugde!
                           'isolation window upper offset' => 1  # fudge!
                         },
                         # mzML structure assumes multiple ions per window; does not ever seem to be the case in Thermo data
                         selected_ion_list => [
                           {
                             selected_ion_param => {
                               'selected ion m/z' => $reaction->precursor,
                               'charge state' => $param->{charge_state}->{$i},
                               'peak intensity' => $parent_scan_data->find_peak_intensity($reaction->precursor) || 0,
                             }
                           }
                         ],
                         activation_param => {
                           ($Finnigan::activationMethod eq 'cid' ? 'collision-induced dissociation' : $Finnigan::activationMethod) => '',
                           'collision energy' => $reaction->energy,
                         }
                        };

      $precursors[-1]->{activation_param_keys} = [grep {exists $precursors[-1]->{activation_param}->{$_}} @activation_param_keys];
    }

    tie my %monoMzAttr, 'Tie::IxHash';
    %monoMzAttr = (
                  name => '[Thermo Trailer Extra]Monoisotopic M/Z:',
                  value => $param->{monoisotopic_mz}{$i},
                  type => 'xsd:float'
                 );

    return {
            ms_level => $ms_power,
            controllerType => 0, # (fudge!) $et->controllerType,
            controllerNumber => 1, # (fudge!) $et->controllerNumber,
            precursor_list => \@precursors,
            length => $length,
            spectrum_param => \%spectrum_param,
            spectrum_param_keys => [grep {exists $spectrum_param{$_}} @spectrum_param_keys],
            scanlist_param => \%scanlist_param,
            scanlist_param_keys => [grep {exists $scanlist_param{$_}} @scanlist_param_keys],
            scan_param => \%scan_param,
            scan_param_keys => [grep {exists $scan_param{$_}} @scan_param_keys],
            scanwindow_param => \%scanwindow_param,
            scanwindow_param_keys => [grep {exists $scanwindow_param{$_}} @scanwindow_param_keys],
            isolation_window_param_keys => \@isolation_window_param_keys,
            selected_ion_param_keys => \@selected_ion_param_keys,
            user_param_keys => ['monoMz'],
            user_param_attr => {monoMz => \%monoMzAttr},
            data_type => $data_type,
            mz_encoded_length => $mz_encoded_length,
            signal_encoded_length => $signal_encoded_length,
            data => $data,
            encoded_mz => $encoded_mz,
            encoded_intensity => $encoded_intensity,
           };
  }
  else {
    unshift @spectrum_param_keys, 'MS1 spectrum';
    $spectrum_param{'MS1 spectrum'} = '';
    return {
            ms_level => $ms_power,
            controllerType => 0, # (fudge!) $et->controllerType,
            controllerNumber => 1, # (fudge!) $et->controllerNumber,
            length => $length,
            spectrum_param => \%spectrum_param,
            spectrum_param_keys => [grep {exists $spectrum_param{$_}} @spectrum_param_keys],
            scanlist_param => \%scanlist_param,
            scanlist_param_keys => [grep {exists $scanlist_param{$_}} @scanlist_param_keys],
            scan_param => \%scan_param,
            scan_param_keys => [grep {exists $scan_param{$_}} @scan_param_keys],
            scanwindow_param => \%scanwindow_param,
            scanwindow_param_keys => [grep {exists $scanwindow_param{$_}} @scanwindow_param_keys],
            data_type => $data_type,
            mz_encoded_length => $mz_encoded_length,
            signal_encoded_length => $signal_encoded_length,
            data => $data,
            encoded_mz => $encoded_mz,
            encoded_intensity => $encoded_intensity,
           };
  }
}

sub cvAttributesFor {
  my ($name, $scanData, $param_group) = @_;
  my $value = $scanData->{$param_group}->{$name};
  $value = sprintf("%f", $value) if looks_like_number($value) and $name =~ m{observed m/z};
  tie my %attr, 'Tie::IxHash';
  if ( $ms_unit{$name} ) {
    %attr = (
             cvRef => 'MS',
             accession => $accession{$name} || 'unknown',
             name => $name,
             value => $value,
             unitCvRef => 'MS',
             unitAccession => $accession{$ms_unit{$name}},
             unitName => $ms_unit{$name}
            );
  }
  elsif ( $uo_unit{$name} ) {
    %attr = (
             cvRef => 'MS',
             accession => $accession{$name} || 'unknown',
             name => $name,
             value => $scanData->{$param_group}->{$name},
             unitCvRef => 'UO',
             unitAccession => $accession{$uo_unit{$name}},
             unitName => $uo_unit{$name}
            );
  }
  else {
    %attr = (
             cvRef => 'MS',
             accession => $accession{$name} || 'unknown',
             name => $name,
             value => $scanData->{$param_group}->{$name}
            );
  }
  return \%attr;
}

sub get_stat_info {  ## this will only work in Linux
  my $ref = {};

  ### open and read the main stat file
  if( ! open(_INFO,"</proc/$$/stat") ){
    die "Couldn't open /proc/$$/stat [$!]";
  }
  my @info = split(/\s+/,<_INFO>);
  close(_INFO);

  ### these are all the props (skip some)
  # pid(0) comm(1) state ppid pgrp session tty
  # tpgid(7) flags minflt cminflt majflt cmajflt
  # utime(13) stime cutime cstime counter
  # priority(18) timeout itrealvalue starttime vsize rss
  # rlim(24) startcode endcode startstack kstkesp kstkeip
  # signal(30) blocked sigignore sigcatch wchan
  ###

  ### get the important ones
  $ref = {utime  => $info[13] / 100,
          stime  => $info[14] / 100,
          cutime => $info[15] / 100,
          cstime => $info[16] / 100,
          vsize  => $info[22],
          rss    => $info[23] * 4};

  return $ref;
}


# Local Variables:
# indent-tabs-mode: nil
# tab-width: 2
# End:

__END__
=head1 NAME

uf-mzml - convert a Finnigan raw file to mzML

=head1 SYNOPSIS

uf-mzml [options] <file>

 Options:

  -a[ctivationMethod] <symbol>     specify ion activation method [CID by default]
  -c[entroids]                     write peak centroids instead of scan profiles where possible
  -r[ange] <from> .. <to>          write only scans with numbers between <from> and <to>
  -q[uiet]                         suppress the instrument error messages
  -u[nencoded]                     render the data unencoded (in decimal encoding)
  -s[tructure]                     output just the XML structure of the file (without the data)
  <file>                           input file

=head1 OPTIONS

=over 4

=item B<-help>

Prints a brief help message and exits.

=item B<-a[ctivationMethod] <symbolE<gt>>

Since the native storage location of the data element corresponding to the activation method is unknown at this time, the required B<mzML> activation attribute is set to 'collision-induced dissociation' by default. It is a valid assumption in most Orbitrap experiments. The B<-a> option overrides the default value. The symbol specified on the command line is simply copied into the C<activation> element, provided it exists in the mzML controlled vocabulary. A small fragment of the vocabulary included in B<uf-mzml> consists of:

  'collision-induced dissociation'
  'surface-induced dissociation'
  'electron capture dissociation'
  'electron transfer dissociation'
  'photodissociation'
  'multiphoton dissociation'
  'infrared multiphoton dissociation'


=item B<-c[entroids]>

Prefer centroids to raw profiles.

B<Note:> presently, B<uf-mzml> does not do its own centroiding. If a scan contains no centroid data, the profile is written out.

=item B<-r[ange] E<lt>from:0+nE<gt> .. E<lt>to:0+nE<gt>>

Selects a range of scans to process.

B<Note:> in order to establish valid references within the B<mzXML> file, the first scan in the selected range has be a full MS1 scan. Otherwise, the program will exit with the following message:

  C<Range error: cannot form valid mzML starting with the dependent scan ###>

To determine the appropriate range of scans, list all scans in the file using B<uf-trailer>.

=item B<-q[uiet]>

Suppress the instrument error messages stored in the input file. Without this option, the error messages will be printed to STDERR.

=item B<-u[nencoded]>

Dump the contents of each C<binary> element in human-readable decimal encoding

=item B<-s[tructure]>

Do not output scan data, preserving the overall structure of the XML
document.  This option is useful in troubleshooting the structure of
the output file and its metadata.

=back

=head1 SEE ALSO

Finnigan::Scan
Finnigan::Profile
Finnigan::ProfileChunk
uf-trailer

=head1 EXAMPLES

 uf-mzml sample.raw > sample.mzML

  (convert the entire file, using profiles from those scans where both
  profiles and centroids are present and centroids where there are no
  profiles)

 uf-mzml -c sample.raw > sample.mzML

  (convert the entire file, extracting precomputed centroids from
  every scancontaining centroids; where there are no centroids, the
  profile will be used)

 uf-mzxml -c -r 350 .. 352 20070522_NH_Orbi2_HelaEpo_05.RAW > sample.mzML

  (extract peak centroids from scans 350 through 352)

 uf-mzml -a "electron transfer dissociation" sample.raw > sample.mzML

  (override the default dissociation method)

=cut