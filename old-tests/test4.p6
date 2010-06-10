#!/usr/bin/env perl6

sub md5_hex (Str $message) {
    my $md5_sum = Q:PIR {
        load_bytecode 'Digest/MD5.pbc'
        .local pmc md5sum, md5_sum_get
        md5sum = get_root_global ['parrot'; 'Digest'], '_md5sum'
        $P0 = find_lex '$message'
        $P1 = md5sum($P0)
        md5_sum_get = get_root_global ['parrot'; 'Digest'], '_md5_hex'
        %r = md5_sum_get($P1)
    };
    return $md5_sum;
}

say md5_hex('foo');

