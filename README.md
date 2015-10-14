## Perl6 Digest::MD5 module

An interface-compatible port of
[Perl 5 Digest::MD5](https://metacpan.org/pod/Digest::MD5) to Perl 6.

Cosimo Streppone (cosimo@cpan.org)

### Synopsis

```perl6
    use Digest::MD5;
    say Digest::MD5.new.md5_hex("My awesome data to hash");
```

### Methods

#### `new`

```perl6
    my $d = Digest::MD5.new;
```

Returns a new `Digest::MD5` object.

#### `md5_hex`

```perl6
    my $md5_hash = $d.md5_hex('data');

    my @data = "one", "two", "and more";
    my $md5_hash = $d.md5_hex( @data );

    # returns string '009ef1defa9fa27032f9f52cdeda8698'
```

Takes either a string or an array as the argument and returns MD5 hash
as a hex string.

#### `md5_buf`

```perl6
    my $md5_buf = $d.md5_buf('data');

    # returns Buf:0x<8d 77 7f 38 5d 3d fe c8 81 5d 20 f7 49 60 26 dc>
```

Takes same arguments as `md5_hex`, except returns a
[Buf](http://docs.perl6.org/type/Buf) instead of a string.

### Repository

  http://github.com/cosimo/perl6-digest-md5

### Current status (2012-01-31)

Should work with latest (2012.01) release
of Rakudo, the "nom" branch-based version.

