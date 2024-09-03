import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

/// {@template expense}
/// Expense model
/// {@endtemplate}
@JsonSerializable()
class Expense extends Equatable {
  /// The id of the expense
  @JsonKey(includeToJson: false)
  final String? id;

  /// The category of the expense
  final String category;
  final String nameOfItem;
  final dynamic estimatedAmount;

  const Expense({
    this.id,
    required this.category,
    required this.nameOfItem,
    required this.estimatedAmount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  Expense copyWith({
    String? id,
    String? category,
    String? nameOfItem,
    dynamic estimatedAmount,
  }) {
    return Expense(
      id: id ?? this.id,
      category: category ?? this.category,
      nameOfItem: nameOfItem ?? this.nameOfItem,
      estimatedAmount: estimatedAmount ?? this.estimatedAmount,
    );
  }

  static const empty = Expense(
    id: '',
    category: '',
    nameOfItem: '',
    estimatedAmount: 0.0,
  );

  @override
  List<Object?> get props => [id, category, nameOfItem, estimatedAmount];
}
