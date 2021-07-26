import 'package:bitcoin_jsonrpc/bitcoin_jsonrpc.dart';
import 'package:ninja/ninja.dart';
import 'package:test/test.dart';

void main() {
  group('hash160', () {
    test('hash160', () {
      final v = bigIntToBytes(BigInt.parse(
          '03485328BA704D5A910CD8B7D2D6232DE67277B7F28811AD28918FF20C54A37F5A',
          radix: 16));
      expect(hash160(v), 'afa05beb3362a52c4998976b6f68ceab6aa0985e');
    });
  });
}
