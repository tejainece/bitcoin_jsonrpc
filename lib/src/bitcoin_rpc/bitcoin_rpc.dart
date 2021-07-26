import 'package:bitcoin_jsonrpc/src/bitcoin_rpc/models/models.dart';
import 'package:bitcoin_jsonrpc/src/jsonrpc/http.dart';
import 'package:bitcoin_jsonrpc/src/jsonrpc/models.dart';
import 'package:http/http.dart';

class BitcoinRPC {
  late JRPCHttpClient jrpc;

  BitcoinRPC(Uri uri, {Client? client, BasicAuth? basicAuth}) {
    jrpc = JRPCHttpClient(uri, client: client, basicAuth: basicAuth);
  }

  Future<BigInt> getBlockCount() async {
    final params = <dynamic>[];
    final resp = await jrpc.callRPC(
      JRPCRequest(
        id: jrpc.nextId,
        method: 'getblockcount',
        params: params,
      ),
    );
    if (resp.error != null) {
      throw resp.error!;
    }
    return BigInt.parse(resp.result.toString());
  }

  Future<String> getBlockHash(BigInt blockNumber) async {
    final params = <dynamic>[blockNumber.toInt()];
    final resp = await jrpc.callRPC(
      JRPCRequest(
        id: jrpc.nextId,
        method: 'getblockhash',
        params: params,
      ),
    );
    if (resp.error != null) {
      throw resp.error!;
    }
    return resp.result as String;
  }

  Future<String> getBlockVerbosity0(String blockHash) async {
    final params = <dynamic>[blockHash, 0];
    final resp = await jrpc.callRPC(
      JRPCRequest(
        id: jrpc.nextId,
        method: 'getblock',
        params: params,
      ),
    );
    if (resp.error != null) {
      throw resp.error!;
    }
    return resp.result as String;
  }

  Future<Block> getBlockVerbosity1(String blockHash) async {
    final params = <dynamic>[blockHash, 1];
    final resp = await jrpc.callRPC(
      JRPCRequest(
        id: jrpc.nextId,
        method: 'getblock',
        params: params,
      ),
    );
    if (resp.error != null) {
      throw resp.error!;
    }
    return Block.fromMap(resp.result as Map);
  }

  Future<Block> getBlockVerbosity2(String blockHash) async {
    final params = <dynamic>[blockHash, 2];
    final resp = await jrpc.callRPC(
      JRPCRequest(
        id: jrpc.nextId,
        method: 'getblock',
        params: params,
      ),
    );
    if (resp.error != null) {
      throw resp.error!;
    }
    return Block.fromMap(resp.result as Map);
  }
}
