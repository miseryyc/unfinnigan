# This Makefile is for the Finnigan extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.56 (Revision: 65600) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: (q[PREFIX=/home/miseryyc])
#

#   MakeMaker Parameters:

#     ABSTRACT_FROM => q[lib/Finnigan.pm]
#     AUTHOR => q[Gene Selkov <selkovjr@gmail.com>]
#     BUILD_REQUIRES => {  }
#     EXE_FILES => [q[bin/uf-header], q[bin/uf-seqrow], q[bin/uf-casinfo], q[bin/uf-rfi], q[bin/uf-meth], q[bin/uf-scan], q[bin/uf-runheader], q[bin/uf-instrument], q[bin/uf-log], q[bin/uf-error], q[bin/uf-segments], q[bin/uf-params], q[bin/uf-tune], q[bin/uf-index], q[bin/uf-trailer], q[bin/uf-mzxml], q[bin/mzxml-unpack]]
#     LICENSE => q[perl]
#     NAME => q[Finnigan]
#     PREREQ_PM => { Getopt::Long=>q[2.37], XML::Generator=>q[1.03], Tie::IxHash=>q[1.21], Data::Hexdumper=>q[2.01], Storable=>q[2.18], Carp=>q[1.08], Encode=>q[2.23], MIME::Base64=>q[3.07], File::Temp=>q[0.21], Module::Find=>q[0.06], Devel::Size=>q[0.71], Getopt::Declare=>q[1.13] }
#     VERSION_FROM => q[lib/Finnigan.pm]

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/lib/perl/5.12/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = cc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = cc
LDDLFLAGS = -shared -O2 -g -L/usr/local/lib -fstack-protector
LDFLAGS =  -fstack-protector -L/usr/local/lib
LIBC = 
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 2.6.24-28-server
RANLIB = :
SITELIBEXP = /usr/local/share/perl/5.12.4
SITEARCHEXP = /usr/local/lib/perl/5.12.4
SO = so
VENDORARCHEXP = /usr/lib/perl5
VENDORLIBEXP = /usr/share/perl5


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = Finnigan
NAME_SYM = Finnigan
VERSION = 0.0205
VERSION_MACRO = VERSION
VERSION_SYM = 0_0205
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 0.0205
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1p
MAN3EXT = 3pm
INSTALLDIRS = site
DESTDIR = 
PREFIX = /home/miseryyc
PERLPREFIX = $(PREFIX)
SITEPREFIX = $(PREFIX)
VENDORPREFIX = $(PREFIX)
INSTALLPRIVLIB = $(PERLPREFIX)/share/perl/5.12
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = $(SITEPREFIX)/share/perl/5.12.4
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = $(VENDORPREFIX)/share/perl5
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = $(PERLPREFIX)/lib/perl/5.12
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = $(SITEPREFIX)/lib/perl/5.12.4
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = $(VENDORPREFIX)/lib/perl5
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = $(PERLPREFIX)/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = $(SITEPREFIX)/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = $(VENDORPREFIX)/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = $(PERLPREFIX)/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = $(SITEPREFIX)/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = $(VENDORPREFIX)/bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = $(PERLPREFIX)/share/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = $(SITEPREFIX)/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = $(VENDORPREFIX)/share/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = $(PERLPREFIX)/share/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = $(SITEPREFIX)/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = $(VENDORPREFIX)/share/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB = /usr/share/perl/5.12
PERL_ARCHLIB = /usr/lib/perl/5.12
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/lib/perl/5.12/CORE
PERL = /usr/bin/perl
FULLPERL = /usr/bin/perl
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/share/perl/5.12/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.56
MM_REVISION = 65600

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = Finnigan
BASEEXT = Finnigan
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = lib/Finnigan.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = bin/mzxml-unpack \
	bin/uf-casinfo \
	bin/uf-error \
	bin/uf-header \
	bin/uf-index \
	bin/uf-instrument \
	bin/uf-log \
	bin/uf-meth \
	bin/uf-mzxml \
	bin/uf-params \
	bin/uf-rfi \
	bin/uf-runheader \
	bin/uf-scan \
	bin/uf-segments \
	bin/uf-seqrow \
	bin/uf-trailer \
	bin/uf-tune
MAN3PODS = lib/Finnigan.pm \
	lib/Finnigan/AuditTag.pm \
	lib/Finnigan/CASInfo.pm \
	lib/Finnigan/CASInfoPreamble.pm \
	lib/Finnigan/Decoder.pm \
	lib/Finnigan/Error.pm \
	lib/Finnigan/FileHeader.pm \
	lib/Finnigan/FractionCollector.pm \
	lib/Finnigan/GenericDataDescriptor.pm \
	lib/Finnigan/GenericDataHeader.pm \
	lib/Finnigan/GenericRecord.pm \
	lib/Finnigan/InjectionData.pm \
	lib/Finnigan/InstID.pm \
	lib/Finnigan/InstrumentLogRecord.pm \
	lib/Finnigan/MethodFile.pm \
	lib/Finnigan/OLE2DIF.pm \
	lib/Finnigan/OLE2DirectoryEntry.pm \
	lib/Finnigan/OLE2FAT.pm \
	lib/Finnigan/OLE2File.pm \
	lib/Finnigan/OLE2Header.pm \
	lib/Finnigan/OLE2Property.pm \
	lib/Finnigan/PacketHeader.pm \
	lib/Finnigan/Peak.pm \
	lib/Finnigan/Peaks.pm \
	lib/Finnigan/Profile.pm \
	lib/Finnigan/ProfileChunk.pm \
	lib/Finnigan/RawFileInfo.pm \
	lib/Finnigan/RawFileInfoPreamble.pm \
	lib/Finnigan/Reaction.pm \
	lib/Finnigan/RunHeader.pm \
	lib/Finnigan/SampleInfo.pm \
	lib/Finnigan/Scan.pm \
	lib/Finnigan/ScanEvent.pm \
	lib/Finnigan/ScanEventPreamble.pm \
	lib/Finnigan/ScanEventTemplate.pm \
	lib/Finnigan/ScanIndexEntry.pm \
	lib/Finnigan/ScanParameters.pm \
	lib/Finnigan/SeqRow.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DFSEP)Config.pm $(PERL_INC)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)
INST_ARCHLIBDIR  = $(INST_ARCHLIB)

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/Finnigan.pm \
	lib/Finnigan/AuditTag.pm \
	lib/Finnigan/CASInfo.pm \
	lib/Finnigan/CASInfoPreamble.pm \
	lib/Finnigan/Decoder.pm \
	lib/Finnigan/Error.pm \
	lib/Finnigan/FileHeader.pm \
	lib/Finnigan/FractionCollector.pm \
	lib/Finnigan/GenericDataDescriptor.pm \
	lib/Finnigan/GenericDataHeader.pm \
	lib/Finnigan/GenericRecord.pm \
	lib/Finnigan/InjectionData.pm \
	lib/Finnigan/InstID.pm \
	lib/Finnigan/InstrumentLogRecord.pm \
	lib/Finnigan/MethodFile.pm \
	lib/Finnigan/OLE2DIF.pm \
	lib/Finnigan/OLE2DirectoryEntry.pm \
	lib/Finnigan/OLE2FAT.pm \
	lib/Finnigan/OLE2File.pm \
	lib/Finnigan/OLE2Header.pm \
	lib/Finnigan/OLE2Property.pm \
	lib/Finnigan/PacketHeader.pm \
	lib/Finnigan/Peak.pm \
	lib/Finnigan/Peaks.pm \
	lib/Finnigan/Profile.pm \
	lib/Finnigan/ProfileChunk.pm \
	lib/Finnigan/RawFileInfo.pm \
	lib/Finnigan/RawFileInfoPreamble.pm \
	lib/Finnigan/Reaction.pm \
	lib/Finnigan/RunHeader.pm \
	lib/Finnigan/SampleInfo.pm \
	lib/Finnigan/Scan.pm \
	lib/Finnigan/ScanEvent.pm \
	lib/Finnigan/ScanEventPreamble.pm \
	lib/Finnigan/ScanEventTemplate.pm \
	lib/Finnigan/ScanIndexEntry.pm \
	lib/Finnigan/ScanParameters.pm \
	lib/Finnigan/SeqRow.pm

PM_TO_BLIB = lib/Finnigan/Peak.pm \
	blib/lib/Finnigan/Peak.pm \
	lib/Finnigan/Reaction.pm \
	blib/lib/Finnigan/Reaction.pm \
	lib/Finnigan/CASInfoPreamble.pm \
	blib/lib/Finnigan/CASInfoPreamble.pm \
	lib/Finnigan/FileHeader.pm \
	blib/lib/Finnigan/FileHeader.pm \
	lib/Finnigan/FractionCollector.pm \
	blib/lib/Finnigan/FractionCollector.pm \
	lib/Finnigan/InstrumentLogRecord.pm \
	blib/lib/Finnigan/InstrumentLogRecord.pm \
	lib/Finnigan/SeqRow.pm \
	blib/lib/Finnigan/SeqRow.pm \
	lib/Finnigan/MethodFile.pm \
	blib/lib/Finnigan/MethodFile.pm \
	lib/Finnigan/OLE2File.pm \
	blib/lib/Finnigan/OLE2File.pm \
	lib/Finnigan/ScanEventTemplate.pm \
	blib/lib/Finnigan/ScanEventTemplate.pm \
	lib/Finnigan/AuditTag.pm \
	blib/lib/Finnigan/AuditTag.pm \
	lib/Finnigan/Error.pm \
	blib/lib/Finnigan/Error.pm \
	lib/Finnigan/Profile.pm \
	blib/lib/Finnigan/Profile.pm \
	lib/Finnigan/OLE2Property.pm \
	blib/lib/Finnigan/OLE2Property.pm \
	lib/Finnigan/OLE2Header.pm \
	blib/lib/Finnigan/OLE2Header.pm \
	lib/Finnigan/ScanParameters.pm \
	blib/lib/Finnigan/ScanParameters.pm \
	lib/Finnigan/GenericDataHeader.pm \
	blib/lib/Finnigan/GenericDataHeader.pm \
	lib/Finnigan/PacketHeader.pm \
	blib/lib/Finnigan/PacketHeader.pm \
	lib/Finnigan/GenericDataDescriptor.pm \
	blib/lib/Finnigan/GenericDataDescriptor.pm \
	lib/Finnigan/Decoder.pm \
	blib/lib/Finnigan/Decoder.pm \
	lib/Finnigan/CASInfo.pm \
	blib/lib/Finnigan/CASInfo.pm \
	lib/Finnigan/ScanIndexEntry.pm \
	blib/lib/Finnigan/ScanIndexEntry.pm \
	lib/Finnigan/SampleInfo.pm \
	blib/lib/Finnigan/SampleInfo.pm \
	lib/Finnigan/RawFileInfoPreamble.pm \
	blib/lib/Finnigan/RawFileInfoPreamble.pm \
	lib/Finnigan/ProfileChunk.pm \
	blib/lib/Finnigan/ProfileChunk.pm \
	lib/Finnigan/ScanEventPreamble.pm \
	blib/lib/Finnigan/ScanEventPreamble.pm \
	lib/Finnigan/InjectionData.pm \
	blib/lib/Finnigan/InjectionData.pm \
	lib/Finnigan/Peaks.pm \
	blib/lib/Finnigan/Peaks.pm \
	lib/Finnigan/OLE2DirectoryEntry.pm \
	blib/lib/Finnigan/OLE2DirectoryEntry.pm \
	lib/Finnigan.pm \
	blib/lib/Finnigan.pm \
	lib/Finnigan/InstID.pm \
	blib/lib/Finnigan/InstID.pm \
	lib/Finnigan/OLE2DIF.pm \
	blib/lib/Finnigan/OLE2DIF.pm \
	lib/Finnigan/Scan.pm \
	blib/lib/Finnigan/Scan.pm \
	lib/Finnigan/OLE2FAT.pm \
	blib/lib/Finnigan/OLE2FAT.pm \
	lib/Finnigan/RawFileInfo.pm \
	blib/lib/Finnigan/RawFileInfo.pm \
	lib/Finnigan/GenericRecord.pm \
	blib/lib/Finnigan/GenericRecord.pm \
	lib/Finnigan/RunHeader.pm \
	blib/lib/Finnigan/RunHeader.pm \
	lib/Finnigan/ScanEvent.pm \
	blib/lib/Finnigan/ScanEvent.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.56
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(TRUE)
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e 'mkpath' --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e 'eqtime' --
FALSE = false
TRUE = true
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install([ from_to => {@ARGV}, verbose => '\''$(VERBINST)'\'', uninstall_shadows => '\''$(UNINST)'\'', dir_mode => '\''$(PERM_DIR)'\'' ]);' --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'perllocal_install' --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'uninstall' --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'warn_if_old_packlist' --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(ABSPERLRUN) -MExtUtils::MY -e 'MY->fixin(shift)' --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(NOECHO) $(NOOP)
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = Finnigan
DISTVNAME = Finnigan-0.0205


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	PREFIX="$(PREFIX)"


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(INST_DYNAMIC) $(INST_BOOT)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	bin/uf-params \
	bin/uf-runheader \
	bin/uf-index \
	bin/uf-rfi \
	bin/uf-tune \
	bin/uf-header \
	bin/mzxml-unpack \
	bin/uf-segments \
	bin/uf-instrument \
	bin/uf-meth \
	bin/uf-seqrow \
	bin/uf-scan \
	bin/uf-casinfo \
	bin/uf-trailer \
	bin/uf-log \
	bin/uf-error \
	bin/uf-mzxml \
	lib/Finnigan/Peak.pm \
	lib/Finnigan/Reaction.pm \
	lib/Finnigan/CASInfoPreamble.pm \
	lib/Finnigan/FileHeader.pm \
	lib/Finnigan/FractionCollector.pm \
	lib/Finnigan/InstrumentLogRecord.pm \
	lib/Finnigan/SeqRow.pm \
	lib/Finnigan/MethodFile.pm \
	lib/Finnigan/OLE2File.pm \
	lib/Finnigan/ScanEventTemplate.pm \
	lib/Finnigan/AuditTag.pm \
	lib/Finnigan/Error.pm \
	lib/Finnigan/Profile.pm \
	lib/Finnigan/OLE2Property.pm \
	lib/Finnigan/OLE2Header.pm \
	lib/Finnigan/ScanParameters.pm \
	lib/Finnigan/GenericDataHeader.pm \
	lib/Finnigan/PacketHeader.pm \
	lib/Finnigan/GenericDataDescriptor.pm \
	lib/Finnigan/Decoder.pm \
	lib/Finnigan/CASInfo.pm \
	lib/Finnigan/ScanIndexEntry.pm \
	lib/Finnigan/SampleInfo.pm \
	lib/Finnigan/RawFileInfoPreamble.pm \
	lib/Finnigan/ProfileChunk.pm \
	lib/Finnigan/ScanEventPreamble.pm \
	lib/Finnigan/InjectionData.pm \
	lib/Finnigan/Peaks.pm \
	lib/Finnigan/OLE2DirectoryEntry.pm \
	lib/Finnigan.pm \
	lib/Finnigan/InstID.pm \
	lib/Finnigan/OLE2DIF.pm \
	lib/Finnigan/Scan.pm \
	lib/Finnigan/OLE2FAT.pm \
	lib/Finnigan/RawFileInfo.pm \
	lib/Finnigan/GenericRecord.pm \
	lib/Finnigan/RunHeader.pm \
	lib/Finnigan/ScanEvent.pm
	$(NOECHO) $(POD2MAN) --section=$(MAN1EXT) --perm_rw=$(PERM_RW) \
	  bin/uf-params $(INST_MAN1DIR)/uf-params.$(MAN1EXT) \
	  bin/uf-runheader $(INST_MAN1DIR)/uf-runheader.$(MAN1EXT) \
	  bin/uf-index $(INST_MAN1DIR)/uf-index.$(MAN1EXT) \
	  bin/uf-rfi $(INST_MAN1DIR)/uf-rfi.$(MAN1EXT) \
	  bin/uf-tune $(INST_MAN1DIR)/uf-tune.$(MAN1EXT) \
	  bin/uf-header $(INST_MAN1DIR)/uf-header.$(MAN1EXT) \
	  bin/mzxml-unpack $(INST_MAN1DIR)/mzxml-unpack.$(MAN1EXT) \
	  bin/uf-segments $(INST_MAN1DIR)/uf-segments.$(MAN1EXT) \
	  bin/uf-instrument $(INST_MAN1DIR)/uf-instrument.$(MAN1EXT) \
	  bin/uf-meth $(INST_MAN1DIR)/uf-meth.$(MAN1EXT) \
	  bin/uf-seqrow $(INST_MAN1DIR)/uf-seqrow.$(MAN1EXT) \
	  bin/uf-scan $(INST_MAN1DIR)/uf-scan.$(MAN1EXT) \
	  bin/uf-casinfo $(INST_MAN1DIR)/uf-casinfo.$(MAN1EXT) \
	  bin/uf-trailer $(INST_MAN1DIR)/uf-trailer.$(MAN1EXT) \
	  bin/uf-log $(INST_MAN1DIR)/uf-log.$(MAN1EXT) \
	  bin/uf-error $(INST_MAN1DIR)/uf-error.$(MAN1EXT) \
	  bin/uf-mzxml $(INST_MAN1DIR)/uf-mzxml.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) \
	  lib/Finnigan/Peak.pm $(INST_MAN3DIR)/Finnigan::Peak.$(MAN3EXT) \
	  lib/Finnigan/Reaction.pm $(INST_MAN3DIR)/Finnigan::Reaction.$(MAN3EXT) \
	  lib/Finnigan/CASInfoPreamble.pm $(INST_MAN3DIR)/Finnigan::CASInfoPreamble.$(MAN3EXT) \
	  lib/Finnigan/FileHeader.pm $(INST_MAN3DIR)/Finnigan::FileHeader.$(MAN3EXT) \
	  lib/Finnigan/FractionCollector.pm $(INST_MAN3DIR)/Finnigan::FractionCollector.$(MAN3EXT) \
	  lib/Finnigan/InstrumentLogRecord.pm $(INST_MAN3DIR)/Finnigan::InstrumentLogRecord.$(MAN3EXT) \
	  lib/Finnigan/SeqRow.pm $(INST_MAN3DIR)/Finnigan::SeqRow.$(MAN3EXT) \
	  lib/Finnigan/MethodFile.pm $(INST_MAN3DIR)/Finnigan::MethodFile.$(MAN3EXT) \
	  lib/Finnigan/OLE2File.pm $(INST_MAN3DIR)/Finnigan::OLE2File.$(MAN3EXT) \
	  lib/Finnigan/ScanEventTemplate.pm $(INST_MAN3DIR)/Finnigan::ScanEventTemplate.$(MAN3EXT) \
	  lib/Finnigan/AuditTag.pm $(INST_MAN3DIR)/Finnigan::AuditTag.$(MAN3EXT) \
	  lib/Finnigan/Error.pm $(INST_MAN3DIR)/Finnigan::Error.$(MAN3EXT) \
	  lib/Finnigan/Profile.pm $(INST_MAN3DIR)/Finnigan::Profile.$(MAN3EXT) \
	  lib/Finnigan/OLE2Property.pm $(INST_MAN3DIR)/Finnigan::OLE2Property.$(MAN3EXT) \
	  lib/Finnigan/OLE2Header.pm $(INST_MAN3DIR)/Finnigan::OLE2Header.$(MAN3EXT) \
	  lib/Finnigan/ScanParameters.pm $(INST_MAN3DIR)/Finnigan::ScanParameters.$(MAN3EXT) \
	  lib/Finnigan/GenericDataHeader.pm $(INST_MAN3DIR)/Finnigan::GenericDataHeader.$(MAN3EXT) \
	  lib/Finnigan/PacketHeader.pm $(INST_MAN3DIR)/Finnigan::PacketHeader.$(MAN3EXT) \
	  lib/Finnigan/GenericDataDescriptor.pm $(INST_MAN3DIR)/Finnigan::GenericDataDescriptor.$(MAN3EXT) \
	  lib/Finnigan/Decoder.pm $(INST_MAN3DIR)/Finnigan::Decoder.$(MAN3EXT) \
	  lib/Finnigan/CASInfo.pm $(INST_MAN3DIR)/Finnigan::CASInfo.$(MAN3EXT) \
	  lib/Finnigan/ScanIndexEntry.pm $(INST_MAN3DIR)/Finnigan::ScanIndexEntry.$(MAN3EXT) \
	  lib/Finnigan/SampleInfo.pm $(INST_MAN3DIR)/Finnigan::SampleInfo.$(MAN3EXT) \
	  lib/Finnigan/RawFileInfoPreamble.pm $(INST_MAN3DIR)/Finnigan::RawFileInfoPreamble.$(MAN3EXT) \
	  lib/Finnigan/ProfileChunk.pm $(INST_MAN3DIR)/Finnigan::ProfileChunk.$(MAN3EXT) \
	  lib/Finnigan/ScanEventPreamble.pm $(INST_MAN3DIR)/Finnigan::ScanEventPreamble.$(MAN3EXT) \
	  lib/Finnigan/InjectionData.pm $(INST_MAN3DIR)/Finnigan::InjectionData.$(MAN3EXT) \
	  lib/Finnigan/Peaks.pm $(INST_MAN3DIR)/Finnigan::Peaks.$(MAN3EXT) \
	  lib/Finnigan/OLE2DirectoryEntry.pm $(INST_MAN3DIR)/Finnigan::OLE2DirectoryEntry.$(MAN3EXT) \
	  lib/Finnigan.pm $(INST_MAN3DIR)/Finnigan.$(MAN3EXT) \
	  lib/Finnigan/InstID.pm $(INST_MAN3DIR)/Finnigan::InstID.$(MAN3EXT) \
	  lib/Finnigan/OLE2DIF.pm $(INST_MAN3DIR)/Finnigan::OLE2DIF.$(MAN3EXT) \
	  lib/Finnigan/Scan.pm $(INST_MAN3DIR)/Finnigan::Scan.$(MAN3EXT) \
	  lib/Finnigan/OLE2FAT.pm $(INST_MAN3DIR)/Finnigan::OLE2FAT.$(MAN3EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) \
	  lib/Finnigan/RawFileInfo.pm $(INST_MAN3DIR)/Finnigan::RawFileInfo.$(MAN3EXT) \
	  lib/Finnigan/GenericRecord.pm $(INST_MAN3DIR)/Finnigan::GenericRecord.$(MAN3EXT) \
	  lib/Finnigan/RunHeader.pm $(INST_MAN3DIR)/Finnigan::RunHeader.$(MAN3EXT) \
	  lib/Finnigan/ScanEvent.pm $(INST_MAN3DIR)/Finnigan::ScanEvent.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = bin/uf-header bin/uf-seqrow bin/uf-casinfo bin/uf-rfi bin/uf-meth bin/uf-scan bin/uf-runheader bin/uf-instrument bin/uf-log bin/uf-error bin/uf-segments bin/uf-params bin/uf-tune bin/uf-index bin/uf-trailer bin/uf-mzxml bin/mzxml-unpack

pure_all :: $(INST_SCRIPT)/uf-params $(INST_SCRIPT)/uf-runheader $(INST_SCRIPT)/uf-index $(INST_SCRIPT)/uf-rfi $(INST_SCRIPT)/uf-tune $(INST_SCRIPT)/uf-header $(INST_SCRIPT)/mzxml-unpack $(INST_SCRIPT)/uf-segments $(INST_SCRIPT)/uf-instrument $(INST_SCRIPT)/uf-meth $(INST_SCRIPT)/uf-seqrow $(INST_SCRIPT)/uf-scan $(INST_SCRIPT)/uf-casinfo $(INST_SCRIPT)/uf-trailer $(INST_SCRIPT)/uf-log $(INST_SCRIPT)/uf-error $(INST_SCRIPT)/uf-mzxml
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/uf-params $(INST_SCRIPT)/uf-runheader \
	  $(INST_SCRIPT)/uf-index $(INST_SCRIPT)/uf-rfi \
	  $(INST_SCRIPT)/uf-tune $(INST_SCRIPT)/uf-header \
	  $(INST_SCRIPT)/mzxml-unpack $(INST_SCRIPT)/uf-segments \
	  $(INST_SCRIPT)/uf-instrument $(INST_SCRIPT)/uf-meth \
	  $(INST_SCRIPT)/uf-seqrow $(INST_SCRIPT)/uf-scan \
	  $(INST_SCRIPT)/uf-casinfo $(INST_SCRIPT)/uf-trailer \
	  $(INST_SCRIPT)/uf-log $(INST_SCRIPT)/uf-error \
	  $(INST_SCRIPT)/uf-mzxml 

$(INST_SCRIPT)/uf-params : bin/uf-params $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-params
	$(CP) bin/uf-params $(INST_SCRIPT)/uf-params
	$(FIXIN) $(INST_SCRIPT)/uf-params
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-params

$(INST_SCRIPT)/uf-runheader : bin/uf-runheader $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-runheader
	$(CP) bin/uf-runheader $(INST_SCRIPT)/uf-runheader
	$(FIXIN) $(INST_SCRIPT)/uf-runheader
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-runheader

$(INST_SCRIPT)/uf-index : bin/uf-index $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-index
	$(CP) bin/uf-index $(INST_SCRIPT)/uf-index
	$(FIXIN) $(INST_SCRIPT)/uf-index
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-index

$(INST_SCRIPT)/uf-rfi : bin/uf-rfi $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-rfi
	$(CP) bin/uf-rfi $(INST_SCRIPT)/uf-rfi
	$(FIXIN) $(INST_SCRIPT)/uf-rfi
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-rfi

$(INST_SCRIPT)/uf-tune : bin/uf-tune $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-tune
	$(CP) bin/uf-tune $(INST_SCRIPT)/uf-tune
	$(FIXIN) $(INST_SCRIPT)/uf-tune
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-tune

$(INST_SCRIPT)/uf-header : bin/uf-header $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-header
	$(CP) bin/uf-header $(INST_SCRIPT)/uf-header
	$(FIXIN) $(INST_SCRIPT)/uf-header
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-header

$(INST_SCRIPT)/mzxml-unpack : bin/mzxml-unpack $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/mzxml-unpack
	$(CP) bin/mzxml-unpack $(INST_SCRIPT)/mzxml-unpack
	$(FIXIN) $(INST_SCRIPT)/mzxml-unpack
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/mzxml-unpack

$(INST_SCRIPT)/uf-segments : bin/uf-segments $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-segments
	$(CP) bin/uf-segments $(INST_SCRIPT)/uf-segments
	$(FIXIN) $(INST_SCRIPT)/uf-segments
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-segments

$(INST_SCRIPT)/uf-instrument : bin/uf-instrument $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-instrument
	$(CP) bin/uf-instrument $(INST_SCRIPT)/uf-instrument
	$(FIXIN) $(INST_SCRIPT)/uf-instrument
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-instrument

$(INST_SCRIPT)/uf-meth : bin/uf-meth $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-meth
	$(CP) bin/uf-meth $(INST_SCRIPT)/uf-meth
	$(FIXIN) $(INST_SCRIPT)/uf-meth
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-meth

$(INST_SCRIPT)/uf-seqrow : bin/uf-seqrow $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-seqrow
	$(CP) bin/uf-seqrow $(INST_SCRIPT)/uf-seqrow
	$(FIXIN) $(INST_SCRIPT)/uf-seqrow
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-seqrow

$(INST_SCRIPT)/uf-scan : bin/uf-scan $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-scan
	$(CP) bin/uf-scan $(INST_SCRIPT)/uf-scan
	$(FIXIN) $(INST_SCRIPT)/uf-scan
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-scan

$(INST_SCRIPT)/uf-casinfo : bin/uf-casinfo $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-casinfo
	$(CP) bin/uf-casinfo $(INST_SCRIPT)/uf-casinfo
	$(FIXIN) $(INST_SCRIPT)/uf-casinfo
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-casinfo

$(INST_SCRIPT)/uf-trailer : bin/uf-trailer $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-trailer
	$(CP) bin/uf-trailer $(INST_SCRIPT)/uf-trailer
	$(FIXIN) $(INST_SCRIPT)/uf-trailer
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-trailer

$(INST_SCRIPT)/uf-log : bin/uf-log $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-log
	$(CP) bin/uf-log $(INST_SCRIPT)/uf-log
	$(FIXIN) $(INST_SCRIPT)/uf-log
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-log

$(INST_SCRIPT)/uf-error : bin/uf-error $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-error
	$(CP) bin/uf-error $(INST_SCRIPT)/uf-error
	$(FIXIN) $(INST_SCRIPT)/uf-error
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-error

$(INST_SCRIPT)/uf-mzxml : bin/uf-mzxml $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/uf-mzxml
	$(CP) bin/uf-mzxml $(INST_SCRIPT)/uf-mzxml
	$(FIXIN) $(INST_SCRIPT)/uf-mzxml
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/uf-mzxml



# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  *$(LIB_EXT) core \
	  core.[0-9] $(INST_ARCHAUTODIR)/extralibs.all \
	  core.[0-9][0-9] $(BASEEXT).bso \
	  pm_to_blib.ts core.[0-9][0-9][0-9][0-9] \
	  $(BASEEXT).x $(BOOTSTRAP) \
	  perl$(EXE_EXT) tmon.out \
	  *$(OBJ_EXT) pm_to_blib \
	  $(INST_ARCHAUTODIR)/extralibs.ld blibdirs.ts \
	  core.[0-9][0-9][0-9][0-9][0-9] *perl.core \
	  core.*perl.*.? $(MAKE_APERL_FILE) \
	  perl $(BASEEXT).def \
	  core.[0-9][0-9][0-9] mon.out \
	  lib$(BASEEXT).def perlmain.c \
	  perl.exe so_locations \
	  $(BASEEXT).exp 
	- $(RM_RF) \
	  blib 
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(MAKEFILE_OLD) $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile : create_distdir
	$(NOECHO) $(ECHO) Generating META.yml
	$(NOECHO) $(ECHO) '--- #YAML:1.0' > META_new.yml
	$(NOECHO) $(ECHO) 'name:               Finnigan' >> META_new.yml
	$(NOECHO) $(ECHO) 'version:            0.0205' >> META_new.yml
	$(NOECHO) $(ECHO) 'abstract:           Thermo/Finnigan mass spec data decoder' >> META_new.yml
	$(NOECHO) $(ECHO) 'author:' >> META_new.yml
	$(NOECHO) $(ECHO) '    - Gene Selkov <selkovjr@gmail.com>' >> META_new.yml
	$(NOECHO) $(ECHO) 'license:            perl' >> META_new.yml
	$(NOECHO) $(ECHO) 'distribution_type:  module' >> META_new.yml
	$(NOECHO) $(ECHO) 'configure_requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '    ExtUtils::MakeMaker:  0' >> META_new.yml
	$(NOECHO) $(ECHO) 'build_requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '    ExtUtils::MakeMaker:  0' >> META_new.yml
	$(NOECHO) $(ECHO) 'requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '    Carp:             1.08' >> META_new.yml
	$(NOECHO) $(ECHO) '    Data::Hexdumper:  2.01' >> META_new.yml
	$(NOECHO) $(ECHO) '    Devel::Size:      0.71' >> META_new.yml
	$(NOECHO) $(ECHO) '    Encode:           2.23' >> META_new.yml
	$(NOECHO) $(ECHO) '    File::Temp:       0.21' >> META_new.yml
	$(NOECHO) $(ECHO) '    Getopt::Declare:  1.13' >> META_new.yml
	$(NOECHO) $(ECHO) '    Getopt::Long:     2.37' >> META_new.yml
	$(NOECHO) $(ECHO) '    MIME::Base64:     3.07' >> META_new.yml
	$(NOECHO) $(ECHO) '    Module::Find:     0.06' >> META_new.yml
	$(NOECHO) $(ECHO) '    Storable:         2.18' >> META_new.yml
	$(NOECHO) $(ECHO) '    Tie::IxHash:      1.21' >> META_new.yml
	$(NOECHO) $(ECHO) '    XML::Generator:   1.03' >> META_new.yml
	$(NOECHO) $(ECHO) 'no_index:' >> META_new.yml
	$(NOECHO) $(ECHO) '    directory:' >> META_new.yml
	$(NOECHO) $(ECHO) '        - t' >> META_new.yml
	$(NOECHO) $(ECHO) '        - inc' >> META_new.yml
	$(NOECHO) $(ECHO) 'generated_by:       ExtUtils::MakeMaker version 6.56' >> META_new.yml
	$(NOECHO) $(ECHO) 'meta-spec:' >> META_new.yml
	$(NOECHO) $(ECHO) '    url:      http://module-build.sourceforge.net/META-spec-v1.4.html' >> META_new.yml
	$(NOECHO) $(ECHO) '    version:  1.4' >> META_new.yml
	-$(NOECHO) $(MV) META_new.yml $(DISTVNAME)/META.yml


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old 



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir distmeta 
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL "PREFIX=/home/miseryyc"
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{META.yml} => q{Module meta-data (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add META.yml to MANIFEST: $${'\''@'\''}\n"' --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add SIGNATURE to MANIFEST: $${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		$(INST_LIB) $(DESTINSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLARCHLIB) \
		$(INST_BIN) $(DESTINSTALLBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install :: all
	$(NOECHO) umask 02; $(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLSITELIB) \
		$(INST_ARCHLIB) $(DESTINSTALLSITEARCH) \
		$(INST_BIN) $(DESTINSTALLSITEBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSITESCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLSITEMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLVENDORSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)

doc_perl_install :: all

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLSITEARCH)/perllocal.pod
	-$(NOECHO) umask 02; $(MKPATH) $(DESTINSTALLSITEARCH)
	-$(NOECHO) umask 02; $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLSITEARCH)/perllocal.pod

doc_vendor_install :: all


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist

uninstall_from_vendordirs ::



# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL "PREFIX=/home/miseryyc"
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR= \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS= \
		PREFIX=/home/miseryyc


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/*.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)


test_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="0.0205">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Thermo/Finnigan mass spec data decoder</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Gene Selkov &lt;selkovjr@gmail.com&gt;</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Carp::" VERSION="1.08" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Data::Hexdumper" VERSION="2.01" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Devel::Size" VERSION="0.71" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Encode::" VERSION="2.23" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="File::Temp" VERSION="0.21" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Getopt::Declare" VERSION="1.13" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Getopt::Long" VERSION="2.37" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="MIME::Base64" VERSION="3.07" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Module::Find" VERSION="0.06" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Storable::" VERSION="2.18" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Tie::IxHash" VERSION="1.21" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="XML::Generator" VERSION="1.03" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="i686-linux-gnu-thread-multi-64int-5.12" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/Finnigan/Peak.pm blib/lib/Finnigan/Peak.pm \
	  lib/Finnigan/Reaction.pm blib/lib/Finnigan/Reaction.pm \
	  lib/Finnigan/CASInfoPreamble.pm blib/lib/Finnigan/CASInfoPreamble.pm \
	  lib/Finnigan/FileHeader.pm blib/lib/Finnigan/FileHeader.pm \
	  lib/Finnigan/FractionCollector.pm blib/lib/Finnigan/FractionCollector.pm \
	  lib/Finnigan/InstrumentLogRecord.pm blib/lib/Finnigan/InstrumentLogRecord.pm \
	  lib/Finnigan/SeqRow.pm blib/lib/Finnigan/SeqRow.pm \
	  lib/Finnigan/MethodFile.pm blib/lib/Finnigan/MethodFile.pm \
	  lib/Finnigan/OLE2File.pm blib/lib/Finnigan/OLE2File.pm \
	  lib/Finnigan/ScanEventTemplate.pm blib/lib/Finnigan/ScanEventTemplate.pm \
	  lib/Finnigan/AuditTag.pm blib/lib/Finnigan/AuditTag.pm \
	  lib/Finnigan/Error.pm blib/lib/Finnigan/Error.pm \
	  lib/Finnigan/Profile.pm blib/lib/Finnigan/Profile.pm \
	  lib/Finnigan/OLE2Property.pm blib/lib/Finnigan/OLE2Property.pm \
	  lib/Finnigan/OLE2Header.pm blib/lib/Finnigan/OLE2Header.pm \
	  lib/Finnigan/ScanParameters.pm blib/lib/Finnigan/ScanParameters.pm \
	  lib/Finnigan/GenericDataHeader.pm blib/lib/Finnigan/GenericDataHeader.pm \
	  lib/Finnigan/PacketHeader.pm blib/lib/Finnigan/PacketHeader.pm \
	  lib/Finnigan/GenericDataDescriptor.pm blib/lib/Finnigan/GenericDataDescriptor.pm \
	  lib/Finnigan/Decoder.pm blib/lib/Finnigan/Decoder.pm \
	  lib/Finnigan/CASInfo.pm blib/lib/Finnigan/CASInfo.pm \
	  lib/Finnigan/ScanIndexEntry.pm blib/lib/Finnigan/ScanIndexEntry.pm \
	  lib/Finnigan/SampleInfo.pm blib/lib/Finnigan/SampleInfo.pm \
	  lib/Finnigan/RawFileInfoPreamble.pm blib/lib/Finnigan/RawFileInfoPreamble.pm \
	  lib/Finnigan/ProfileChunk.pm blib/lib/Finnigan/ProfileChunk.pm \
	  lib/Finnigan/ScanEventPreamble.pm blib/lib/Finnigan/ScanEventPreamble.pm \
	  lib/Finnigan/InjectionData.pm blib/lib/Finnigan/InjectionData.pm \
	  lib/Finnigan/Peaks.pm blib/lib/Finnigan/Peaks.pm \
	  lib/Finnigan/OLE2DirectoryEntry.pm blib/lib/Finnigan/OLE2DirectoryEntry.pm \
	  lib/Finnigan.pm blib/lib/Finnigan.pm \
	  lib/Finnigan/InstID.pm blib/lib/Finnigan/InstID.pm \
	  lib/Finnigan/OLE2DIF.pm blib/lib/Finnigan/OLE2DIF.pm \
	  lib/Finnigan/Scan.pm blib/lib/Finnigan/Scan.pm \
	  lib/Finnigan/OLE2FAT.pm blib/lib/Finnigan/OLE2FAT.pm \
	  lib/Finnigan/RawFileInfo.pm blib/lib/Finnigan/RawFileInfo.pm \
	  lib/Finnigan/GenericRecord.pm blib/lib/Finnigan/GenericRecord.pm \
	  lib/Finnigan/RunHeader.pm blib/lib/Finnigan/RunHeader.pm \
	  lib/Finnigan/ScanEvent.pm blib/lib/Finnigan/ScanEvent.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
