import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:formz_input/formz_input.dart';

part 'expense_form_state.dart';

class ExpenseFormCubit extends Cubit<ExpenseFormState> {
  ExpenseFormCubit() : super(const ExpenseFormState());

  void categoryChanged(String value) {
    final category = Field.dirty(value);
    emit(
      state.copyWith(
        category: category,
        isValid: Formz.validate(
          [category, state.nameOfItem, state.amount],
        ),
      ),
    );
  }

  void nameOfItemChanged(String value) {
    final nameOfItem = Field.dirty(value);
    emit(
      state.copyWith(
        nameOfItem: nameOfItem,
        isValid: Formz.validate(
          [
            state.category,
            nameOfItem,
            state.amount,
          ],
        ),
      ),
    );
  }

  void amountChanged(double value) {
    final amount = DoubleField.dirty(value);
    emit(
      state.copyWith(
        amount: amount,
        isValid: Formz.validate(
          [
            state.category,
            state.nameOfItem,
            amount,
          ],
        ),
      ),
    );
  }

  onSubmitExpense() {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
  }
}
