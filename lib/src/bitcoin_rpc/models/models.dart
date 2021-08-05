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
  final List<Transaction>? transactions;
  final List<String>? transactionStrings;
  final DateTime time;
  final DateTime medianTime;
  final int nonce;
  final String bits;
  final double difficulty;
  final String chainwork;
  final int numTransactions;
  final String previousBlockHash;
  final String? nextBlockHash;

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
      this.transactions,
      this.transactionStrings,
      required this.time,
      required this.medianTime,
      required this.nonce,
      required this.bits,
      required this.difficulty,
      required this.chainwork,
      required this.numTransactions,
      required this.previousBlockHash,
      required this.nextBlockHash});

  Transaction? findTxByTxId(String txId) {
    if(transactions == null) {
      throw Exception('does not have verbose transactions');
    }
    for(final tx in transactions!) {
      if(tx.txId == txId) {
        return tx;
      }
    }
    return null;
  }

  static Block fromMap(Map map) {
    List<String>? txStrings;
    List<Transaction>? txs;
    if ((map['tx'] as List).isNotEmpty) {
      if ((map['tx'] as List).first is String) {
        txStrings = (map['tx'] as List).cast<String>();
      } else {
        txs = (map['tx'] as List).cast<Map>().map(Transaction.fromMap).toList();
      }
    } else {
      txStrings = [];
      txs = [];
    }
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
      transactions: txs,
      transactionStrings: txStrings,
      time: toDateTime(map['time'])!,
      medianTime: toDateTime(map['mediantime'])!,
      nonce: map['nonce'],
      bits: map['bits'],
      difficulty: (map['difficulty'] as num).toDouble(),
      chainwork: map['chainwork'],
      numTransactions: map['nTx'],
      previousBlockHash: map['previousblockhash'],
      nextBlockHash: map['nextblockhash'],
    );
  }
}

class Transaction {
  final bool? inActiveChain;
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
  final String? blockHash;
  final int? confirmations;
  final DateTime? blockTime;
  final DateTime? time;

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
    return Transaction(
      inActiveChain: map['in_active_chain'],
      hex: map['hex'],
      txId: map['txid'],
      hash: map['hash'],
      size: map['size'],
      virtualSize: map['vsize'],
      weight: map['weight'],
      version: map['version'],
      lockTime: toDateTime(map['locktime'])!,
      vins: (map['vin'] as List).cast<Map>().map(Vin.fromMap).toList(),
      vouts: (map['vout'] as List).cast<Map>().map(Vout.fromMap).toList(),
      blockHash: map['blockhash'],
      confirmations: map['confirmations'],
      blockTime: toDateTime(map['blocktime']),
      time: toDateTime(map['time']),
    );
  }
}

class Vin {
  final String? txId;
  final int? voutIndex;
  final dynamic scriptSig;
  final List<String>? txInWitness;
  final BigInt sequence;
  final String? coinbase;

  Vin({
    required this.txId,
    required this.voutIndex,
    required this.scriptSig,
    required this.txInWitness,
    required this.sequence,
    required this.coinbase,
  });

  static Vin fromMap(Map map) {
    return Vin(
      txId: map['txid'],
      voutIndex: map['vout'],
      scriptSig: map['scriptSig'],
      txInWitness: (map['txinwitness'] as List?)?.cast<String>(),
      sequence: BigInt.parse(map['sequence'].toString()),
      coinbase: map['coinbase'],
    );
  }
}

class Vout {
  final double value;
  final int voutIndex;
  final ScriptPubKey scriptPubKey;

  Vout(
      {required this.value,
      required this.voutIndex,
      required this.scriptPubKey});

  static Vout fromMap(Map map) {
    return Vout(
      value: (map['value'] as num).toDouble(),
      voutIndex: map['n'],
      scriptPubKey: ScriptPubKey.fromMap(map['scriptPubKey']),
    );
  }
}

class ScriptPubKey {
  final String asm;
  final String hex;
  final int? reqSigs;
  final String type;
  final List<String> addresses;
  final Map originalBody;
  ScriptPubKey({
    required this.asm,
    required this.hex,
    required this.reqSigs,
    required this.type,
    required this.addresses,
    required this.originalBody,
  });

  Map<String, dynamic> toJson() => {
        'asm': asm,
        'hex': hex,
        'reqSigs': reqSigs,
        'type': type,
        'addresses': addresses,
      };

  static ScriptPubKey fromMap(Map map) {
    return ScriptPubKey(
      asm: map['asm'],
      hex: map['hex'],
      reqSigs: map['reqSigs'],
      type: map['type'],
      addresses: ((map['addresses'] ?? []) as List).cast<String>(),
      originalBody: map,
    );
  }
}

DateTime? toDateTime(int? epoch) {
  if (epoch == null) {
    return null;
  }
  return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
}
