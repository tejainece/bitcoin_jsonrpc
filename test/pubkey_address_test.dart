import 'package:bitcoin_jsonrpc/src/address/public_key.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('pubkey', () {
    test('toAddress', () {
      final pubk = PublicKey.decode(
          '0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352');
      expect(pubk.toBitcoinAddress(), '1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs');
    });
  });
  group('bech32', () {
    test('toBitcoinBech32.0', () {
      final pubk = PublicKey.decode(
          '0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352');
      expect(pubk.toBitcoinBech32(), '1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs');
    });
    test('toBitcoinBech32.1', () {
      final pubk = PublicKey.decode(
          '0279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798');
      expect(pubk.toBitcoinBech32(), 'bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4');
    });
  });
}
