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

  String toBitcoinAddress({bool? compressed, int prefix = 0x00}) {
    final hash = bitcoinHashBytes(compressed: compressed).toList();
    hash.insert(0, prefix);
    final checksum =
        sha256.convert(sha256.convert(hash).bytes).bytes.sublist(0, 4);
    hash.addAll(checksum);
    return base58.encode(Uint8List.fromList(hash));
  }

  Uint8List bitcoinHashBytes({bool? compressed}) {
    final encoded = encodeIntoBytes(compressed: compressed ?? this.compressed);
    return hash160IntoBytes(encoded);
  }

  String bitcoinHash({bool? compressed}) {
    final encoded = encodeIntoBytes(compressed: compressed ?? this.compressed);
    return hash160(encoded);
  }
}

class AddressPrefix {
  /// Leading 1
  static const p2pkh = 0x00;
  /// Leading 3
  static const p2sh = 0x05;
  /// Leading m or n
  static const p2pkhTestnet = 0x6F;
  /// Leading 2
  static const p2shTestnet = 0xC4;
}
