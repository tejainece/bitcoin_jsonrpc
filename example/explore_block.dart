import 'dart:io';

import 'package:bitcoin_jsonrpc/bitcoin_jsonrpc.dart';
import 'package:bitcoin_jsonrpc/src/jsonrpc/http.dart';

Future<void> main() async {
  final rpc = BitcoinRPC(
    Uri.parse('http://001.chandrayaan.finance:8888/cryptorpc/btc/testnet'),
    basicAuth: BasicAuth(
      username: Platform.environment['BTCRPCUSER']!,
      password: Platform.environment['BTCRPCPWD']!,
    ),
  );
  final hash = '0000000000000040b63be99a414af2a784d2a848fec03e32d1d4cdc7e01c291d';
  print(hash);
  /*final blockSer = await rpc.getBlockVerbosity0(hash);
  print(blockSer);*/
  final block = await rpc.getBlockVerbosity2(hash);
  print(block.height);
  final tx = block.findTxByTxId('4dc587be68e41178f8feab2767498c1c2170691fcc21ebe399af0e98fce09aee')!;
  print(tx.hash);
}
