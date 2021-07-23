import 'dart:convert';
import 'dart:io';

import 'package:bitcoin_jsonrpc/src/jsonrpc/models.dart';
import 'package:http/http.dart';

class BasicAuth {
  final String username;
  final String password;
  BasicAuth({required this.username, required this.password});
  String encode() {
    return base64Encode(utf8.encode('$username:$password'));
  }

  @override
  String toString() => encode();
}

abstract class JRPCClient {
  String get nextId;
  Future<JRPCResponse> callRPC(JRPCRequest req);
}

class JRPCHttpClient implements JRPCClient {
  final Uri uri;
  late Client client;
  BasicAuth? basicAuth;

  BigInt _id = BigInt.from(0);

  JRPCHttpClient(this.uri, {Client? client, this.basicAuth}) {
    this.client = client ?? Client();
  }

  @override
  String get nextId {
    _id = _id + BigInt.one;
    return _id.toString();
  }

  @override
  Future<JRPCResponse> callRPC(JRPCRequest req) async {
    final body = json.encode(req.toJson());
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json-rpc',
      HttpHeaders.acceptHeader: 'application/json-rpc'
    };
    if (basicAuth != null) {
      headers[HttpHeaders.authorizationHeader] = 'Basic $basicAuth';
    }
    final resp = await client.post(uri, headers: headers, body: body);
    return JRPCResponse.fromMap(json.decode(resp.body));
  }
}
