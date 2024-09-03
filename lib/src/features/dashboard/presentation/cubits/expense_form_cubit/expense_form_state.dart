part of 'expense_form_cubit.dart';

final class ExpenseFormState extends Equatable {
  const ExpenseFormState({
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.category = const Field.pure(),
    this.nameOfItem = const Field.pure(),
    this.amount = const DoubleField.pure(),
  });

  final FormzSubmissionStatus status;
  final bool isValid;
  final Field category;
  final Field nameOfItem;
  final DoubleField amount;

  ExpenseFormState copyWith({
    FormzSubmissionStatus? status,
    bool? isValid,
    Field? category,
    Field? nameOfItem,
    DoubleField? amount,
  }) {
    return ExpenseFormState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      category: category ?? this.category,
      nameOfItem: nameOfItem ?? this.nameOfItem,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object> get props => [status, isValid, category, nameOfItem, amount];
}
