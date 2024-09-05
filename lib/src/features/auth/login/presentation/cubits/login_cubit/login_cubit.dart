import 'package:equatable/equatable.dart';
import 'package:expense_api/expense_api.dart';
import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:formz_input/formz_input.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required ExpenseApiRepository expenseApiRepository,
  })  : _expenseApiRepository = expenseApiRepository,
        super(const LoginState());

  final ExpenseApiRepository _expenseApiRepository;

  void onEmailInput(String emailString) {
    final email = Email.dirty(emailString);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [
            email,
            state.password,
          ],
        ),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void onPasswordInput(String passwordString) {
    final password = Password.dirty(passwordString);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          [
            state.email,
            password,
          ],
        ),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> onLoginPressed() async {
    if (!state.isValid) return;
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final eitherFailureOrSuccess = await _expenseApiRepository.login(
        loginModel: LoginModel(
          email: state.email.value,
          password: state.password.value,
        ),
      );
      eitherFailureOrSuccess.fold(
        (failure) => emit(
          state.copyWith(
            errorMessage: failure.errorMessage,
            status: FormzSubmissionStatus.failure,
          ),
        ),
        (_) => emit(
          state.copyWith(status: FormzSubmissionStatus.success),
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessage,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}
