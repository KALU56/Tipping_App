// tip_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'tip_model.g.dart';

@JsonSerializable()
class TipModel {
  final String employeeId;
  final double amount;
  final String status;

  TipModel({
    required this.employeeId,
    required this.amount,
    required this.status,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) =>
      _$TipModelFromJson(json);

  Map<String, dynamic> toJson() => _$TipModelToJson(this);
}
