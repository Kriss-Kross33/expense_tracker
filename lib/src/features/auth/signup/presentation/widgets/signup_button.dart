part of '../pages/signup_screen.dart';

class _SignupButton extends StatelessWidget {
  const _SignupButton({required this.constraints});
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: constraints.maxWidth,
      child: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.success) {
            context.pushReplacement(RouteConsts.homeRoute);
          } else if (state.status == FormzSubmissionStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    '${state.errorMessage}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  duration: const Duration(seconds: 3),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                backgroundColor: ColorConsts.violet,
              ),
              onPressed: !state.isValid
                  ? null
                  : () => context.read<SignupCubit>().onSignupPressed(),
              child: state.status.isInProgress
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CupertinoActivityIndicator(
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Signup',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConsts.white,
                                  ),
                        ),
                      ],
                    )
                  : Text(
                      'Signup',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorConsts.white,
                          ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
