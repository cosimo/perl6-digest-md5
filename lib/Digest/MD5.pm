#
# Digest::MD5 Perl6 module
#

class Digest::MD5 {

    pir::load_bytecode('Digest/MD5.pbc');

    multi method md5_hex (Str $message) {

        my $md5_sum = Q:PIR {
            .local pmc md5sum, md5_sum_get
            md5sum = get_root_global ['parrot'; 'Digest'], '_md5sum'
            $P0 = find_lex '$message'
            $P1 = md5sum($P0)
            md5_sum_get = get_root_global ['parrot'; 'Digest'], '_md5_hex'
            %r = md5_sum_get($P1)
        };

        return $md5_sum;
    }

    multi method md5_hex (@message) {
        my Str $message = @message.join('');
        return Digest::MD5.md5_hex($message);
    }

}

