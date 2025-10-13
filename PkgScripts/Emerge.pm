# Ragnarok$

package PkgScripts::Emerge;

use strict;
use warnings;
use IPC::System::Simple qw(runx);
use Exporter 'import';
our @EXPORT_OK = qw(emcmd);

my $cmd		= '/usr/bin/emerge';

sub emcmd {
	my (@args)	= @_;

	eval {
		runx($cmd, @args);
	};

	if ($@) {
		print("Can't run $cmd: $@\n");
	}
}

1;
