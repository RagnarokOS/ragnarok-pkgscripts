#!/usr/bin/env perl

# $Ragnarok: sysupdate.pl,v 1.8 2025/06/04 22:40:15 lecorbeau Exp $
# 
# sysupdate: update Ragnarok base system.

use strict;
use warnings;
use Config::General;
use List::Compare;
use File::Temp qw(tempdir);
use File::chdir;
use Getopt::Long;
Getopt::Long::Configure('pass_through');

# Get values from sysupdate.conf
my $conf	= Config::General->new(
	-ConfigFile		=> '/etc/sysupdate.conf',
	-SplitPolict		=> 'equalsign',
	-InterPolateVars	=> 1
);
my %config	= $conf->getall;
my $mirror	= $config{'MIRROR'};
my $pubkey	= $config{'PUBKEY'};

# Die on error. Instead of constaly writing "or die ...".
sub err {
	my ($err) = @_;

	die("Can't $err file: $!");
}

# Check if updates are found.
sub checkupdate {
	open(my $f1, '<', "index.txt") or err("open");
	open(my $f2, '<', "index.orig.txt") or err("open");

	my @orig = <$f1>;
	my @new = <$f2>;

	my $list = List::Compare->new(\@orig, \@new);
	my @intersection = $list->get_intersection;

	if (!@intersection) {
		print("No updates found\n");
	} else {
		my @updates = $list->get_unique;
		return @updates;
	}
	close($f1) or err("close");
	close($f2) or err("close");
}

# Verify a file sig with signify(1)
sub verify_sig {
	my ($file) = @_;

	system('/usr/bin/signify', "-C", "-p", "$pubkey", "-x", "SHA256.sig", "$file") == 0
		or die("Sig verification failed, exiting.");
}

# Download file as the 'sysupdate' user.
sub download {
	my ($file, $source) = @_;

	# Use lib/download script for the moment.
	system('lib/download', "$destdir", "$file", "$source") == 0
		or die("Download failed: $!\n");
}

# Should this be a subroutine? Perhaps not.
sub main {
	my $dir		= tempdir("sysupdate-XXXXXXXXXX", CLEANUP => 1);
	my $update_dir	= '/var/db/sysupdate';
	my %opts;

	# Download index.txt
	download($dir, 'index.txt', $mirror);

	# Get opts and run
	GetOptions(\%opts,
		'download',
		'list',
		'query',
	);

	# The flags are mutually exclusive.
	if ($opts{'download'}) {
		# handle downloading updates
	} elsif ($opts{'list'}) {
		# handle listing installed updates
	} elsif ($opts{'query'}) {
		# handle checking if updates are available
	} else {
		# handle the default: download and install updates
	}
}
main
