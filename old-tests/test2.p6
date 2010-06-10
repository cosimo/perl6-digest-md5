#!/usr/bin/env perl6

use v6;

sub mysub (Str $text) {
    Q:PIR {
        load_bytecode 'Digest/MD5.pbc'
        .local pmc md5sum, md5print
        md5sum = get_root_global ['parrot'; 'Digest'], '_md5sum'
        $P0 = find_lex '$text'
        $P1 = md5sum($P0)
        md5print = get_root_global ['parrot'; 'Digest'], '_md5_print'
        md5print($P1)
    }
}

mysub('foo');


