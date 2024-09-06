part of 'signup_form.dart';

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField();

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              textFieldkey: const Key('__passwordSignupTextField'),
              obscureText: true,
              isValid: state.password.displayError != null ? false : null,
              hintText: 'Enter your password',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
              keyboardType: TextInputType.visiblePassword,
              onChanged: (String passwordString) =>
                  context.read<SignupCubit>().onPasswordInput(passwordString),
            ),
            SizedBox(
              child: state.password.displayError == null
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Enter a valid password',
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
