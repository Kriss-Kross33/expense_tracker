part of '../pages/signup_screen.dart';

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
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    spreadRadius: 0.2,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: TextField(
                obscureText: showPassword ? false : true,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: showPassword
                        ? Image.asset(AssetConsts.visibilityOff)
                        : Image.asset(AssetConsts.visibility),
                  ),
                  hintText: 'Enter your password',
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.5),
                      ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ColorConsts.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onChanged: (String passwordString) =>
                    context.read<SignupCubit>().onPasswordInput(passwordString),
              ),
            ),
            SizedBox(
              child: state.password.displayError == null
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(left: 15),
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
