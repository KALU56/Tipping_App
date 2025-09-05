import 'package:json_annotation/json_annotation.dart';

part 'tip_model.g.dart';

@JsonSerializable()
class Tip {
  final String customerName;
  final double amount;
  final int time;
  final DateTime date;

  const Tip({
    required this.customerName,
    required this.amount,
    required this.time,
    required this.date,
  });

  // JSON serialization
  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);
  Map<String, dynamic> toJson() => _$TipToJson(this);

  // copyWith method
  Tip copyWith({String? customerName, double? amount, int? time, DateTime? date}) {
    return Tip(
      customerName: customerName ?? this.customerName,
      amount: amount ?? this.amount,
      time: time ?? this.time,
      date: date ?? this.date,
    );
  }
}
