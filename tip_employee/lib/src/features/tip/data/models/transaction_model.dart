class TransactionModel {
  final int? id;
  final String? txRef;
  final String? status;
  final DateTime? createdAt;
  final double? amount;

  TransactionModel({
    this.id,
    this.txRef,
    this.status,
    this.createdAt,
    this.amount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int?,
      txRef: json['tx_ref'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      amount: json['amount'] != null
          ? double.tryParse(json['amount'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tx_ref': txRef,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'amount': amount,
    };
  }
}
