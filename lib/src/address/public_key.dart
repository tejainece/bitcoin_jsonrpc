import 'package:ninja_bip32/ninja_bip32.dart' as bip32;

class PublicKey {
  final BigInt x;
  final BigInt y;
  bool compressed = true;

  PublicKey(this.x, this.y, {this.compressed = true});

  String encode({bool compressed = true}) {
    final pubk = bip32.PublicKey(x, y);
    return pubk.encode(compressed: compressed);
  }

  String toAddress({bool compressed = true}) {
    // TODO
    throw UnimplementedError();
  }

  String hash({bool compressed = true}) {
    // TODO
    throw UnimplementedError();
  }
}
