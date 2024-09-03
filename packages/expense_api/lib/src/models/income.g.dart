// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Income _$IncomeFromJson(Map<String, dynamic> json) => Income(
      id: json['id'] as String?,
      nameOfRevenue: json['nameOfRevenue'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$IncomeToJson(Income instance) => <String, dynamic>{
      'nameOfRevenue': instance.nameOfRevenue,
      'amount': instance.amount,
    };
