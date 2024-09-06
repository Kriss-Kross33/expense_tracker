part of 'signup_form.dart';

class _ConfirmPasswordTextField extends StatefulWidget {
  const _ConfirmPasswordTextField();

  @override
  State<_ConfirmPasswordTextField> createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<_ConfirmPasswordTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              textFieldkey: const Key('__confirmPasswordSignupTextField'),
              isValid:
                  state.confirmPassword.displayError != null ? false : null,
              suffixIcon: IconButton(
                onPressed: () => setState(() => showPassword = !showPassword),
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              hintText: 'Confirm your password',
              keyboardType: TextInputType.visiblePassword,
              onChanged: (String confirmPasswordString) => context
                  .read<SignupCubit>()
                  .onConfirmPasswordInput(confirmPasswordString),
            ),
            SizedBox(
              child: state.confirmPassword.displayError == null
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Passwords do not match',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
