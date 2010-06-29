#
# Digest::MD5 Perl6 module
#

class Digest::MD5 {

    # Use .pir, not .pbc!
    # See https://trac.parrot.org/parrot/ticket/1694
    pir::load_bytecode('Digest/MD5.pir');

    multi method md5_hex (Str $str) {

        my $md5_hex = Q:PIR {
            .local pmc f, g, str
            str = find_lex '$str'
            f = get_root_global ['parrot'; 'Digest'], '_md5sum'
            $P1 = f(str)
            g = get_root_global ['parrot'; 'Digest'], '_md5_hex'
            $S0 = g($P1)
            %r = box $S0
        };

        return $md5_hex;
    }

    multi method md5_hex (@str) {

        my $str = @str.join("");
        my $md5_hex = self.md5_hex($str);
        return $md5_hex;

    }

}

