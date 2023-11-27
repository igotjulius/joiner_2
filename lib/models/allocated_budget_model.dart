import 'package:json_annotation/json_annotation.dart';

part 'allocated_budget_model.g.dart';

@JsonSerializable()
class AllocatedBudgetModel {
  final String? id;
  final double? amount;
  final bool? hasPledged;

  const AllocatedBudgetModel({
    this.id,
    this.amount,
    this.hasPledged
});
  factory AllocatedBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$AllocatedBudgetModelFromJson(json);
  Map<String, dynamic> toJson() => _$AllocatedBudgetModelToJson(this);
}