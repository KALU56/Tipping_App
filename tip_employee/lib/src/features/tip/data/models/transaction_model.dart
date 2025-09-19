class TransactionModel {
  final int id;
  final String txRef;
  final String status;
  final DateTime createdAt;
  final double amount;

  TransactionModel({
    required this.id,
    required this.txRef,
    required this.status,
    required this.createdAt,
    required this.amount,
  });

  // Factory method to create from JSON
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      txRef: json['tx_ref'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
    );
  }

  // Convert back to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tx_ref': txRef,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'amount': amount,
    };
  }
}
