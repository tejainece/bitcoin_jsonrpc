import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hash/hash.dart';

String hash160(List<int> input) {
  final im1 = sha256.convert(input).bytes;
  final bytes = ripemd160(im1);
  return bytes.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
}

Uint8List ripemd160(List<int> msg) =>
    (RIPEMD160()..update(msg)).digest();
