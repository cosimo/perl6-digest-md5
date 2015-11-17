#
# Digest::MD5 Perl6 module
#

class Digest::MD5:auth<cosimo>:ver<0.05> {
    sub prefix:<¬>(\x)       {   (+^ x) % 2**32 }
    sub infix:<⊞>(\x, \y)    {  (x + y) % 2**32 }
    sub infix:«<<<»(\x, \n)  { (x +< n) % 2**32 +| (x +> (32-n)) }

    my \FGHI = -> \X, \Y, \Z { (X +& Y) +| (¬X +& Z) },
               -> \X, \Y, \Z { (X +& Z) +| (Y +& ¬Z) },
               -> \X, \Y, \Z { X +^ Y +^ Z           },
               -> \X, \Y, \Z { Y +^ (X +| ¬Z)        };

    my \S = (
            (7, 12, 17, 22) xx 4,
            (5,  9, 14, 20) xx 4,
            (4, 11, 16, 23) xx 4,
            (6, 10, 15, 21) xx 4,
        ).flat;


    my \T = (floor(abs(sin($_ + 1)) * 2**32) for ^64).flat;

    my \k = (
            (   $_           for ^16),
            ((5*$_ + 1) % 16 for ^16),
            ((3*$_ + 5) % 16 for ^16),
            ((7*$_    ) % 16 for ^16),
        ).flat;


    sub little-endian($w, $n, *@v) { (@v X+> flat ($w X* ^$n)) X% (2 ** $w) }

    sub md5-pad($msg) {
        my \bits = 8 * $msg.elems;
        my @padded = flat $msg.list, 0x80, 0x00 xx (-(bits div 8 + 1 + 8) % 64);
        flat @padded.map({ :256[$^d,$^c,$^b,$^a] }), little-endian(32, 2, bits);
    }

    sub md5-block(@H, @X) {
        my ($A, $B, $C, $D) = @H;
        for ^64 -> \i {
            my \f = FGHI[i div 16]($B, $C, $D);
              ($A, $B,                                         $C, $D)
            = ($D, $B ⊞ (($A ⊞ f ⊞ T[i] ⊞ @X[k[i]]) <<< S[i]), $B, $C);
        }
        @H «⊞=» ($A, $B, $C, $D);
    }

    our sub md5($msg) {
        my @M = md5-pad($msg);
        my @H = 0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476;
        md5-block(@H, @M[$_ .. $_+15]) for 0, 16 ...^ +@M;
        Buf.new: little-endian(8, 4, @H)
    }

    multi method md5_hex(Str $str) {
        md5( $str.encode('latin-1') ).list».fmt('%02x').join
    }

    multi method md5_hex(@str) {
        md5( @str.join.encode('latin-1') ).list».fmt('%02x').join
    }

    multi method md5_buf(Str $str --> Buf) {
        md5( $str.encode('latin-1') );
    }

    multi method md5_buf(@str --> Buf) {
        md5( @str.join.encode('latin-1') );
    }
}
