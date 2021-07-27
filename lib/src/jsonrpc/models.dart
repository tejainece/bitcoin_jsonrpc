import 'dart:convert';

class JRPCRequest {
  final String jsonrpc;
  final String id;
  final String method;
  final Object? params;

  JRPCRequest({
    this.jsonrpc = '1.0',
    required this.id,
    required this.method,
    this.params,
  });

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{
      'jsonrpc': jsonrpc,
      'id': id,
      'method': method,
    };
    if (params != null) {
      ret['params'] = params;
    }
    return ret;
  }

  static JRPCRequest fromMap(Map<String, dynamic> map) {
    return JRPCRequest(
        id: map['id'],
        method: map['method'],
        jsonrpc: map['jsonrpc'],
        params: map['params']);
  }
}

class JRPCResponse {
  final String jsonrpc;
  final String? id;
  final Object? result;
  final Object? error;

  JRPCResponse({this.jsonrpc = '2.0', this.id, this.result, this.error});

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{
      'jsonrpc': jsonrpc,
      'id': id,
    };
    if (result != null) {
      ret['result'] = result;
    }
    if (error != null) {
      ret['error'] = error;
    }
    return ret;
  }

  static JRPCResponse fromMap(Map<String, dynamic> map) => JRPCResponse(
    jsonrpc: map['jsonrpc'] ?? '1.0',
    id: map['id'],
    result: map['result'],
    error: map['error'],
  );
}

class JRPCError {
  final int code;
  final String message;
  final Object? data;
  JRPCError(this.code, this.message, {this.data});

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{'code': code, 'message': message};
    if (data != null) {
      ret['data'] = data;
    }
    return {'code': code, 'message': message};
  }

  static JRPCError fromMap(Map<String, dynamic> map) =>
      JRPCError(map['code'], map['message'], data: map['data']);
}

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