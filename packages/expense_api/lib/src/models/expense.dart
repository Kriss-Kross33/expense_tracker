import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

/// {@template expense}
/// Expense model
/// {@endtemplate}
@JsonSerializable()
class Expense extends Equatable {
  /// The id of the expense
  final String id;

  /// The category of the expense
  final String category;
  final String nameOfItem;
  final double estimatedAmount;

  const Expense({
    required this.id,
    required this.category,
    required this.nameOfItem,
    required this.estimatedAmount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  @override
  List<Object?> get props => [id, category, nameOfItem, estimatedAmount];
}
