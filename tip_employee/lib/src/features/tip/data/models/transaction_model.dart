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

  TransactionModel copyWith({
    int? id,
    String? txRef,
    String? status,
    DateTime? createdAt,
    double? amount,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      txRef: txRef ?? this.txRef,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, txRef: $txRef, status: $status, createdAt: $createdAt, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.id == id &&
        other.txRef == txRef &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        txRef.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        amount.hashCode;
  }
}
