import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hash/hash.dart';

Uint8List hash160IntoBytes(List<int> input) {
  final im1 = sha256.convert(input).bytes;
  return ripemd160(im1);
}

String hash160(List<int> input) {
  final bytes = hash160IntoBytes(input);
  return bytes.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
}

Uint8List ripemd160(List<int> msg) =>
    (RIPEMD160()..update(msg)).digest();
