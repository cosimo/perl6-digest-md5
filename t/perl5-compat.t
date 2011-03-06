#
# Test compability with Perl5 Digest::MD5
#

use Test;
use Digest::MD5;

my @cases = (
    "Hello World"  , 'b10a8db164e0754105b7a99be72e3fe5',
    "Hello World\n", 'e59ff97941044f85df5297e1c302d260',
    ["a", "b"],      '187ef4436122d1cc2f40dc2b92f0eba0',
);

my $digest = Digest::MD5.new;

for @cases -> $values, $md5 {

    is(
        Digest::MD5.md5_hex($values), $md5,
        "MD5 hex of '$values' must be '$md5' (static method)"
    );
   
    is(
        $digest.md5_hex($values), $md5,
        "MD5 hex of '$values' must be '$md5' (instance method)"
    );

}

done;

