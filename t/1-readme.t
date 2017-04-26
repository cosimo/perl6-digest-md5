use v6;
use Digest::MD5;
use Test;

plan 5;
my $d = Digest::MD5.new;
my $expected-buf = Buf.new: 0x8d, 0x77, 0x7f, 0x38, 0x5d, 0x3d, 0xfe, 0xc8, 0x81, 0x5d, 0x20, 0xf7, 0x49, 0x60, 0x26, 0xdc;
my $expected-hash = '009ef1defa9fa27032f9f52cdeda8698';

my $md5_buf_from_str = $d.md5_buf('data');
is-deeply $md5_buf_from_str, $expected-buf, 'md5_buf from str sanity';

my $md5_buf_from_blob = $d.md5_buf('data'.encode('ascii'));
is-deeply $md5_buf_from_blob, $expected-buf, 'md5_buf from blob sanity';

my @data = "one", "two", "and more";
my $md5_hash_from_str_array = $d.md5_hex( @data );
is $md5_hash_from_str_array, $expected-hash, 'md5_hex from str array sanity';
my $md5_hash_from_blob_array = $d.md5_hex( @data.map({ .encode('ascii') }) );
is $md5_hash_from_blob_array, $expected-hash, 'md5_hex from blob array sanity';

my $data = 'data'.encode('utf8');
my $md5_buf = Digest::MD5::md5($data);
is-deeply $md5_buf, $expected-buf, 'Digest::MD5::md5 sanity';
