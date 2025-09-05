// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tip _$TipFromJson(Map<String, dynamic> json) => Tip(
  customerName: json['customerName'] as String,
  amount: (json['amount'] as num).toDouble(),
  time: (json['time'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$TipToJson(Tip instance) => <String, dynamic>{
  'customerName': instance.customerName,
  'amount': instance.amount,
  'time': instance.time,
  'date': instance.date.toIso8601String(),
};
