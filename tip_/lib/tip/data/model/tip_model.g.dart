// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipModel _$TipModelFromJson(Map<String, dynamic> json) => TipModel(
  employeeId: json['employeeId'] as String,
  amount: (json['amount'] as num).toDouble(),
  status: json['status'] as String,
);

Map<String, dynamic> _$TipModelToJson(TipModel instance) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'amount': instance.amount,
  'status': instance.status,
};
