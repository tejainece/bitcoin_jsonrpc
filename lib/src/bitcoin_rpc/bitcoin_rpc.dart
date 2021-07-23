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
}
