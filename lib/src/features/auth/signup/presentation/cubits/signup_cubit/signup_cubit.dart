import 'package:equatable/equatable.dart';
import 'package:expense_api/expense_api.dart';
import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:formz_input/formz_input.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({
    required ExpenseApiRepository expenseApiRepository,
  })  : _expenseApiRepository = expenseApiRepository,
        super(const SignupState());

  final ExpenseApiRepository _expenseApiRepository;

  void onUsernameInput(String nameString) {
    final name = Field.dirty(nameString);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([
          name,
          state.email,
          state.password,
          state.confirmPassword,
        ]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void onEmailInput(String emailString) {
    final email = Email.dirty(emailString);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [
            email,
            state.name,
            state.password,
            state.confirmPassword,
          ],
        ),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void onPasswordInput(String passwordString) {
    final password = Password.dirty(passwordString);
    final confirmPassword = ConfirmPassword.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        isValid: Formz.validate(
          [
            password,
            confirmPassword,
            state.name,
            state.email,
          ],
        ),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void onConfirmPasswordInput(String confirmPasswordString) {
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: confirmPasswordString,
    );
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate(
          [
            confirmPassword,
            state.name,
            state.email,
            state.password,
          ],
        ),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> onSignupPressed() async {
    if (!state.isValid) return;
    try {
      emit(
        state.copyWith(status: FormzSubmissionStatus.inProgress),
      );
      final eitherFailureOrSuccess = await _expenseApiRepository.signup(
        signupModel: SignupModel(
          name: state.name.value,
          email: state.email.value,
          password: state.password.value,
        ),
      );
      eitherFailureOrSuccess.fold(
        (failure) => emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage,
          ),
        ),
        (success) => emit(
          state.copyWith(status: FormzSubmissionStatus.success),
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.errorMessage,
        ),
      );
    }
  }
}
