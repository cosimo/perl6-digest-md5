use v6;
use Digest::MD5;
use Test;

plan 3;
my $d = Digest::MD5.new;
my $expected-buf = Buf.new: 0x8d, 0x77, 0x7f, 0x38, 0x5d, 0x3d, 0xfe, 0xc8, 0x81, 0x5d, 0x20, 0xf7, 0x49, 0x60, 0x26, 0xdc;
my $expected-hash = '009ef1defa9fa27032f9f52cdeda8698';

my $md5_buf = $d.md5_buf('data');
is-deeply $md5_buf, $expected-buf, 'md5_buf sanity';

my @data = "one", "two", "and more";
my $md5_hash = $d.md5_hex( @data );
is $md5_hash, $expected-hash, 'md5_hex sanity';

my $data = 'data'.encode('ascii');
$md5_buf = Digest::MD5::md5($data);
is-deeply $md5_buf, $expected-buf, 'Digest::MD5::md5 sanity';
