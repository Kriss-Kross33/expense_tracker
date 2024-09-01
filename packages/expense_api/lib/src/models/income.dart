import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income.g.dart';

/// {@template expense}
/// Expense model
/// {@endtemplate}
@JsonSerializable()
class Income extends Equatable {
  /// The id of the expense
  final String id;

  /// The category of the expense
  final String category;
  final String nameOfRevenue;
  final double amount;

  const Income({
    required this.id,
    required this.category,
    required this.nameOfRevenue,
    required this.amount,
  });

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeToJson(this);

  @override
  List<Object?> get props => [id, category, nameOfRevenue, amount];
}
