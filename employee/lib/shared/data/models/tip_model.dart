import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tip_model.g.dart';

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  String toJson(TimeOfDay object) {
    return '${object.hour}:${object.minute}';
  }
}

@JsonSerializable()
class Tip {
  final String customerName;
  final double amount;

  @TimeOfDayConverter()
  final TimeOfDay time;

  final DateTime date;

  const Tip({
    required this.customerName,
    required this.amount,
    required this.time,
    required this.date,
  });

  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);
  Map<String, dynamic> toJson() => _$TipToJson(this);

  Tip copyWith({
    String? customerName,
    double? amount,
    TimeOfDay? time,
    DateTime? date,
  }) {
    return Tip(
      customerName: customerName ?? this.customerName,
      amount: amount ?? this.amount,
      time: time ?? this.time,
      date: date ?? this.date,
    );
  }
}
