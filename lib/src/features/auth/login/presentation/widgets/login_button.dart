part of '../pages/login_screen.dart';

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.constraints});
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 48,
          width: constraints.maxWidth,
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == FormzSubmissionStatus.failure) {
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
              } else if (state.status == FormzSubmissionStatus.success) {
                context.pushReplacement(RouteConsts.homeRoute);
              }
            },
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorConsts.lightGreen,
                  ),
                  onPressed: !state.isValid
                      ? null
                      : () => context.read<LoginCubit>().onLoginPressed(),
                  child: state.status.isInProgress
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CupertinoActivityIndicator(
                              color: ColorConsts.black,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Sign in',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        )
                      : Text(
                          'Sign in',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: ColorConsts.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
