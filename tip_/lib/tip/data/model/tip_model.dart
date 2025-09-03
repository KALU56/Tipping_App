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

}
