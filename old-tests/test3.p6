#!/usr/bin/env perl6

use v6;

sub mysub (Str $text) {
    my $md5_sum = Q:PIR {
        load_bytecode 'Digest/MD5.pbc'
        .local pmc md5sum, md5print
        md5sum = get_root_global ['parrot'; 'Digest'], '_md5sum'
        $P0 = find_lex '$text'
        %r = md5sum($P0)
    };
    say $md5_sum;
    return $md5_sum;
}

say mysub('foo');


