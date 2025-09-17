class TipModel {
  final double? netAmount;
  final DateTime date;

  TipModel({
    required this.netAmount,
    required this.date,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      netAmount: json['net_amount'] != null
          ? double.tryParse(json['net_amount'].toString())
          : null,
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'net_amount': netAmount,
      'date': date.toIso8601String(),
    };
  }
}
