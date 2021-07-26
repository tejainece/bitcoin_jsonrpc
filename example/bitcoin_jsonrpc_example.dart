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
  final latestBlock = await rpc.getBlockCount();
  print(latestBlock);
  final hash = await rpc.getBlockHash(latestBlock);
  print(hash);
  /*final blockSer = await rpc.getBlockVerbosity0(hash);
  print(blockSer);*/
  await rpc.getBlockVerbosity1(hash);
  await rpc.getBlockVerbosity2(hash);
}
