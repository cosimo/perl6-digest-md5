#
# Digest::MD5 Perl6 module
#

class Digest::MD5:auth<cosimo>:ver<0.05> {

    # Use .pir, not .pbc!
    # See https://trac.parrot.org/parrot/ticket/1694
    pir::load_bytecode__vs('Digest/MD5.pir');

    multi method md5_hex (Str $str) {

        my $md5_hex = Q:PIR {
            .local pmc f, g, str
            str = find_lex '$str'
            f = get_root_global ['parrot'; 'Digest'], '_md5sum'
            $S0 = repr_unbox_str str
            $P1 = f($S0)
            g = get_root_global ['parrot'; 'Digest'], '_md5_hex'
            $S0 = g($P1)
            %r =  perl6_box_str $S0
        };

        return $md5_hex;
    }

    multi method md5_hex (@str) {

        my $str = @str.join("");
        my $md5_hex = self.md5_hex($str);
        return $md5_hex;

    }

}
