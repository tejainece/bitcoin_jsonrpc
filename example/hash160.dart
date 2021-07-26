import 'package:bitcoin_jsonrpc/bitcoin_jsonrpc.dart';
import 'package:ninja/ninja.dart';

void main() {
  final v = bigIntToBytes(BigInt.parse(
      '03485328BA704D5A910CD8B7D2D6232DE67277B7F28811AD28918FF20C54A37F5A',
      radix: 16));
  print(hash160(v));
}
