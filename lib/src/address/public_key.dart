import 'dart:typed_data';

import 'package:bitcoin_jsonrpc/bitcoin_jsonrpc.dart';
import 'package:crypto/crypto.dart';
import 'package:ninja_bip32/ninja_bip32.dart' as bip32;
import 'package:bs58check/bs58check.dart';

class PublicKey {
  final BigInt x;
  final BigInt y;
  bool compressed = true;

  PublicKey(this.x, this.y, {this.compressed = true});

  factory PublicKey.decode(String encoded) {
    bool compressed = !encoded.startsWith('04');
    final pubk = bip32.PublicKey.decode(encoded);
    return PublicKey(pubk.x, pubk.y, compressed: compressed);
  }

  Uint8List encodeIntoBytes({bool compressed = true}) {
    final pubk = bip32.PublicKey(x, y);
    return pubk.encodeIntoBytes(compressed: compressed);
  }

  String encode({bool compressed = true}) {
    final pubk = bip32.PublicKey(x, y);
    return pubk.encode(compressed: compressed);
  }

  String toAddress({bool? compressed, int prefix = 0x00}) {
    final hash = hashIntoBytes(compressed: compressed).toList();
    hash.insert(0, prefix);
    final checksum = sha256.convert(sha256.convert(hash).bytes).bytes.sublist(0, 4);
    hash.addAll(checksum);
    return base58.encode(Uint8List.fromList(hash));
  }

  Uint8List hashIntoBytes({bool? compressed}) {
    final encoded = encodeIntoBytes(compressed: compressed ?? this.compressed);
    return hash160IntoBytes(encoded);
  }

  String hash({bool? compressed}) {
    final encoded = encodeIntoBytes(compressed: compressed ?? this.compressed);
    return hash160(encoded);
  }
}
