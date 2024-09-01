part of '../pages/login_screen.dart';

class _EmailTextField extends StatelessWidget {
  const _EmailTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
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
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  suffixIcon: Image.asset(AssetConsts.mail),
                  hintText: 'Enter your email',
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
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (String emailString) =>
                    context.read<LoginCubit>().onEmailInput(emailString),
              ),
            ),
            SizedBox(
              child: state.email.displayError == null
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Enter a valid email',
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
