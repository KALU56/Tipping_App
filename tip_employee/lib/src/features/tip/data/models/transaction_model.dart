class TransactionModel {
  final String? id;
  final String? tipId;
  final double? amount;
  final double? fee;
  final DateTime? createdAt;

  TransactionModel({
    this.id,
    this.tipId,
    this.amount,
    this.fee,
    this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String?,
      tipId: json['tip_id'] as String?,
      amount: json['amount'] != null
          ? double.tryParse(json['amount'].toString())
          : null,
      fee: json['fee'] != null
          ? double.tryParse(json['fee'].toString())
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tip_id': tipId,
      'amount': amount,
      'fee': fee,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  TransactionModel copyWith({
    String? id,
    String? tipId,
    double? amount,
    double? fee,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      tipId: tipId ?? this.tipId,
      amount: amount ?? this.amount,
      fee: fee ?? this.fee,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, tipId: $tipId, amount: $amount, fee: $fee, createdAt: $createdAt)';
  }
}
