package PkgScripts::Config;

use strict;
use warnings;
use Config::General;
use Exporter 'import';
our @EXPORT_OK = qw($emerge_opts $setname);

# Change to /etc/pkgscripts.conf when ready
my $conffile	= 'pkgscripts.conf';

my $conf 	= Config::General->new(
	-ConfigFile		=> $conffile,
	-IncludeRelative	=> 1,
	-UseApacheInclude	=> 1,
	-SplitPolicy		=> 'custom',
	-SplitDelimiter		=> '\s+=\s+',
	-InterPolateVars	=> 1,
	-AutoTrue		=> 1
);

my %config		= $conf->getall;
our $emerge_opts	= $config{'EMERGE_OPTS'};
our $set_name		= $config{'SET_NAME'};
