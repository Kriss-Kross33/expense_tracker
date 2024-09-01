part of '../pages/signup_screen.dart';

class _FirstNameTextField extends StatelessWidget {
  const _FirstNameTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                keyboardType: TextInputType.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  suffixIcon: Image.asset(AssetConsts.person),
                  hintText: 'Enter your first name',
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
                onChanged: (String usernameString) =>
                    context.read<SignupCubit>().onUsernameInput(usernameString),
              ),
            ),
            SizedBox(
              child: state.username.displayError == null
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(left: 15),
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
