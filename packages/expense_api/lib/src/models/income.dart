import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income.g.dart';

/// {@template expense}
/// Expense model
/// {@endtemplate}
@JsonSerializable()
class Income extends Equatable {
  /// The id of the expense
  @JsonKey(includeToJson: false)
  final String? id;
  final String nameOfRevenue;
  final double amount;

  const Income({
    this.id,
    required this.nameOfRevenue,
    required this.amount,
  });

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeToJson(this);

  static const empty = Income(
    id: '',
    nameOfRevenue: '',
    amount: 0,
  );

  @override
  List<Object?> get props => [id, nameOfRevenue, amount];
}
