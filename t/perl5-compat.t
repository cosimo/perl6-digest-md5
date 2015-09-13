#
# Test compability with Perl5 Digest::MD5
#

use Test;
use Digest::MD5;

plan 18;

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


    my Buf $md5_buf = Digest::MD5.md5_buf($values);
    is $md5_buf.elems, 16, 'Length of buf is 16 bytes';

    my Str $s = $md5;
    $s ~~ m/(<[0..9A..Za..z]>**2)**16/;
    my Buf $b .= new( map( {:16($_.Str)}, @($/[0][*])));
    is-deeply(
        $md5_buf.list, $b.list,
        "MD5 binary of '$values' (static method)"
    );


    $md5_buf = $digest.md5_buf($values);
    is $md5_buf.elems, 16, 'Length of buf is 16 bytes';

    $s = $md5;
    $s ~~ m/(<[0..9A..Za..z]>**2)**16/;
    $b .= new( map( {:16($_.Str)}, @($/[0][*])));
    is-deeply(
        $md5_buf.list, $b.list,
        "MD5 binary of '$values' (instance method)"
    );
}
