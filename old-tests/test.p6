#!/usr/bin/env perl6

use v6;

Q:PIR {
    load_bytecode 'Digest/MD5.pbc'
    .local pmc md5sum, md5print
    md5sum = get_root_global ['parrot'; 'Digest'], '_md5sum'
    $P0 = md5sum('foo')
    md5print = get_root_global ['parrot'; 'Digest'], '_md5_print'
    md5print($P0)
}

