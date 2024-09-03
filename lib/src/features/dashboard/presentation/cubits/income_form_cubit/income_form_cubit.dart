import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:formz_input/formz_input.dart';

part 'income_form_state.dart';

class IncomeFormCubit extends Cubit<IncomeFormState> {
  IncomeFormCubit() : super(const IncomeFormState());

  void nameOfRevenueChanged(String value) {
    final nameOfRevenue = Field.dirty(value);
    emit(
      state.copyWith(
        nameOfRevenue: nameOfRevenue,
        isValid: Formz.validate(
          [
            nameOfRevenue,
            state.amount,
          ],
        ),
        status: FormzSubmissionStatus.initial,
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
            state.nameOfRevenue,
            amount,
          ],
        ),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }
}
