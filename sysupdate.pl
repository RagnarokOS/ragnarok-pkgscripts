#!/usr/bin/env perl

# $Ragnarok: sysupdate.pl,v 1.5 2025/04/29 17:52:49 lecorbeau Exp ian $
# 
# sysupdate: update Ragnarok base system.

use strict;
use warnings;
use Config::Tiny;
use List::Compare;

# Get values from updates.conf
my $conffile	= 'updates.conf';
my $config	= Config::Tiny->read($conffile);
my $mirror	= $config->{ragnarok}->{MIRROR};
my $pubkey	= $config->{ragnarok}->{PUBKEY};

# Get values from local section if they are defined
my $local_mirror = undef;
my $local_pubkey = undef;
if(defined $config->{local}->{MIRROR}) {
	$local_mirror = $config->{local}->{MIRROR};
	$local_pubkey = $config->{local}->{PUBKEY};
}

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

	# Use 'and' instead of 'or' because system() returns 'false' when it succeeds.
	system('/usr/bin/signify', "-C", "-p", "$pubkey", "-x", "SHA256.sig", "$file")
		and die("Sig verification failed, exiting.");
}

# Download file as the 'sysupdate' user.
sub download {
	my ($file, $source) = @_;

	# Use lib/download script for the moment.
	system('lib/download', "$destdir", "$file", "$source")
		and die("Download failed: $!\n");
}

# Should this be a subroutine? Perhaps not.
sub main {
	my %opts;
	use Getopt::Long;
	Getopt::Long::Configure('pass_through');
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
