#!/usr/bin/env perl

# $Ragnarok: sysupdate.pl,v 1.2 2025/04/28 23:49:53 lecorbeau Exp $
# 
# sysupdate: update Ragnarok base system.

use strict;
use warnings;
use Config::Tiny;
use List::Compare;

# Get values from updates.conf
my $conffile	= 'updates.conf';
my $config	= Config::Tiny->read($conffile);
my $mirror	= $config->{_}->{MIRROR};
my $version	= $config->{_}->{VERSION};
my $pubkey	= $config->{_}->{PUBKEY};
my $url		= "$mirror/$version";

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

sub verify_sig {
	my ($file) = @_;

	# Use 'and' instead of 'or' because system() returns 'false' when it succeeds.
	system('/usr/bin/signify', "-C", "-p", "$pubkey", "-x", "SHA256.sig", "$file")
		and die("Sig verification failed, exiting.");
}
