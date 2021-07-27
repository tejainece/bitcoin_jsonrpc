import 'package:bitcoin_jsonrpc/src/address/public_key.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('pubkey', () {
    test('toAddress', () {
      final pubk = PublicKey.decode(
          '0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352');
      expect(pubk.toAddress(), '1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs');
    });
  });
}
