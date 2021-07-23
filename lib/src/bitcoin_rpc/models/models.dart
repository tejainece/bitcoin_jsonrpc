class Block {
  final String hash;
  final int confirmations;
  final int size;
  final int strippedSize;
  final int weight;
  final int height;
  final int version;
  final String versionHex;
  final String merkleRoot;
  final List<Transaction> transactions;
  final DateTime time;
  final DateTime medianTime;
  final int nonce;
  final String bits;
  final int difficulty;
  final String chainwork;
  final int numTransactions;
  final String previousBlockHash;
  final String nextBlockHash;

  Block(
      {required this.hash,
      required this.confirmations,
      required this.size,
      required this.strippedSize,
      required this.weight,
      required this.height,
      required this.version,
      required this.versionHex,
      required this.merkleRoot,
      required this.transactions,
      required this.time,
      required this.medianTime,
      required this.nonce,
      required this.bits,
      required this.difficulty,
      required this.chainwork,
      required this.numTransactions,
      required this.previousBlockHash,
      required this.nextBlockHash});

  static Block fromMap(Map map) {
    return Block(
      hash: map['hash'],
      confirmations: map['confirmations'],
      size: map['size'],
      strippedSize: map['strippedsize'],
      weight: map['weight'],
      height: map['height'],
      version: map['version'],
      versionHex: map['versionHex'],
      merkleRoot: map['merkleroot'],
      transactions:
          (map['tx'] as List).cast<Map>().map(Transaction.fromMap).toList(),
      time: map['time'],
      medianTime: map['mediantime'],
      nonce: map['nonce'],
      bits: map['bits'],
      difficulty: map['difficulty'],
      chainwork: map['chainwork'],
      numTransactions: map['nTx'],
      previousBlockHash: map['previousblockhash'],
      nextBlockHash: map['nextblockhash'],
    );
  }
}

class Transaction {
  final bool inActiveChain;
  final String hex;
  final String txId;
  final String hash;
  final int size;
  final int virtualSize;
  final int weight;
  final int version;
  final DateTime lockTime;
  final List<Vin> vins;
  final List<Vout> vouts;
  final String blockHash;
  final int confirmations;
  final DateTime blockTime;
  final DateTime time;

  Transaction(
      {required this.inActiveChain,
      required this.hex,
      required this.txId,
      required this.hash,
      required this.size,
      required this.virtualSize,
      required this.weight,
      required this.version,
      required this.lockTime,
      required this.vins,
      required this.vouts,
      required this.blockHash,
      required this.confirmations,
      required this.blockTime,
      required this.time});

  static Transaction fromMap(Map map) {
    return Transaction();
  }
}

class Vin {}

class Vout {}
