import 'dart:typed_data';

import 'package:bitcoin_jsonrpc/bitcoin_jsonrpc.dart';
import 'package:ninja_bip32/ninja_bip32.dart' as bip32;

class PublicKey {
  final BigInt x;
  final BigInt y;
  bool compressed = true;

  PublicKey(this.x, this.y, {this.compressed = true});

  Uint8List encodeIntoBytes({bool compressed = true}) {
    final pubk = bip32.PublicKey(x, y);
    return pubk.encodeIntoBytes(compressed: compressed);
  }

  String encode({bool compressed = true}) {
    final pubk = bip32.PublicKey(x, y);
    return pubk.encode(compressed: compressed);
  }

  String toAddress({bool? compressed}) {
    final hash = this.hash(compressed: compressed);
    // TODO
    throw UnimplementedError();
  }

  String hashIntoBytes({bool? compressed}) {
    final encoded = encodeIntoBytes(compressed: compressed ?? this.compressed);
    return hash160(encoded);
  }

  String hash({bool? compressed}) {
    final encoded = encodeIntoBytes(compressed: compressed ?? this.compressed);
    return hash160(encoded);
  }
}
