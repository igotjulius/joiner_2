import 'package:json_annotation/json_annotation.dart';

part 'expense_model.g.dart';

@JsonSerializable()
class ExpenseModel {
  final String? id;
  final Map<String, double>? items;
  final double? total;
  final bool? splitEqually;

  const ExpenseModel({
    this.id,
    this.items,
    this.total,
    this.splitEqually,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);
}
