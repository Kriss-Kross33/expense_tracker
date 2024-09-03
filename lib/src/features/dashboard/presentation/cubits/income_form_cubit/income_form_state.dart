part of 'income_form_cubit.dart';

final class IncomeFormState extends Equatable {
  const IncomeFormState({
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.nameOfRevenue = const Field.pure(),
    this.amount = const DoubleField.pure(),
  });

  final FormzSubmissionStatus status;
  final bool isValid;
  final Field nameOfRevenue;
  final DoubleField amount;

  IncomeFormState copyWith({
    FormzSubmissionStatus? status,
    bool? isValid,
    Field? nameOfRevenue,
    DoubleField? amount,
  }) {
    return IncomeFormState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      nameOfRevenue: nameOfRevenue ?? this.nameOfRevenue,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object> get props => [status, isValid, nameOfRevenue, amount];
}
