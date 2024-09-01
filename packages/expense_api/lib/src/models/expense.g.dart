// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
      id: json['id'] as String,
      category: json['category'] as String,
      nameOfItem: json['nameOfItem'] as String,
      estimatedAmount: (json['estimatedAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'nameOfItem': instance.nameOfItem,
      'estimatedAmount': instance.estimatedAmount,
    };
