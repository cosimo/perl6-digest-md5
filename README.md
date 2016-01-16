## Perl6 Digest::MD5 module

An interface-compatible port of
[Perl 5 Digest::MD5](https://metacpan.org/pod/Digest::MD5) to Perl 6.

Cosimo Streppone (cosimo@cpan.org)

### Synopsis

```perl6
    use Digest::MD5;
    say Digest::MD5.new.md5_hex('My awesome data to hash');
    # the same as
    say Digest::MD5.new.md5_hex('My awesome data to hash'.encode('ascii'));
```

### Methods

#### `new`

```perl6
    my $d = Digest::MD5.new;
```

Returns a new `Digest::MD5` object.

#### `md5_hex`

```perl6
    my $md5_hash_str = $d.md5_hex('data');
    # the same as
    my $md5_hash_blob = $d.md5_hex('data'.encode('ascii'));

    my @data = "one", "two", "and more";
    my $md5_hash_from_str_array = $d.md5_hex( @data );
    # the same as
    my $md5_hash_from_blob_array = $d.md5_hex( @data.map({ .encode('ascii') }) );

    # returns string '009ef1defa9fa27032f9f52cdeda8698'
```

Takes either a string or an array as the argument and returns MD5 hash
as a hex string.

#### `md5_buf`

```perl6
    my $md5_buf_from_str = $d.md5_buf('data');
    my $md5_buf_from_blob = $d.md5_buf('data'.encode('ascii'));

    # returns Buf:0x<8d 77 7f 38 5d 3d fe c8 81 5d 20 f7 49 60 26 dc>
```

Takes same arguments as `md5_hex`, except returns a
[Buf](http://docs.perl6.org/type/Buf) instead of a string.

### Subroutines

### `Digest::MD5::md5`
```perl6
    my $data = $str.encode('ascii');
    my $md5_buf = Digest::MD5::md5($data);

    # returns Buf:0x<8d 77 7f 38 5d 3d fe c8 81 5d 20 f7 49 60 26 dc>
```

Takes a buffer or array as an argument. Returns a [Buf](http://docs.perl6.org/type/Buf).

### Repository

  http://github.com/cosimo/perl6-digest-md5

### Current status (2012-01-31)

Should work with latest (2012.01) release
of Rakudo, the "nom" branch-based version.

