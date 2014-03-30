use Panda::Common;
use Panda::Builder;
use Shell::Command;

class Build is Panda::Builder {
    method build($workdir) {
        rm_f("$workdir/lib/Digest/MD5.pm");
        if $*VM<name> eq 'parrot' {
            cp("$workdir/lib/Digest/MD5.pm.parrot", "$workdir/lib/Digest/MD5.pm");
        } else {
            cp("$workdir/lib/Digest/MD5.pm.perl", "$workdir/lib/Digest/MD5.pm");
        }
        rm_f("$workdir/lib/Digest/MD5.pm.parrot");
        rm_f("$workdir/lib/Digest/MD5.pm.perl");
    }
}
