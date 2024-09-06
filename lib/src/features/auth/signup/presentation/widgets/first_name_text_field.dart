part of 'signup_form.dart';

class _FirstNameTextField extends StatelessWidget {
  const _FirstNameTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              textFieldkey: const Key('__fullNameSignupTextField'),
              isValid: state.name.displayError != null ? false : null,
              hintText: 'Enter your full name',
              keyboardType: TextInputType.name,
              onChanged: (String usernameString) =>
                  context.read<SignupCubit>().onUsernameInput(usernameString),
              errorText:
                  state.name.displayError != null ? 'Enter a valid name' : null,
            ),
            SizedBox(
              child: state.name.displayError == null
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Enter a valid name',
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
