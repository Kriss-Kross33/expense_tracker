import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/core/core.dart';
import 'package:expense_track/src/features/auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

part '../widgets/email_text_field.dart';
part '../widgets/login_button.dart';
part '../widgets/password_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: BlocProvider(
            create: (context) => LoginCubit(
              expenseApiRepository: context.read<ExpenseApiRepository>(),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Cerene',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontSize: 34, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const Gap(20),
                    Center(
                      child: Image.asset(
                        AssetConsts.loginImg,
                        height: 120,
                        width: 120,
                      ),
                    ),
                    const Gap(20),
                    Center(
                      child: Text(
                        'Improving emotional wellness',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Gap(14),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'Email *',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    const Gap(4),
                    const _EmailTextField(),
                    const Gap(15),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'Password *',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    const Gap(4),
                    const _PasswordTextField(),
                    const Gap(44),
                    _LoginButton(constraints: constraints),
                    const Gap(10),
                    const Row(
                      children: [
                        SizedBox.shrink(),
                        Spacer(),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont\'t have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        TextButton(
                          child: Text(
                            'Sign up',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorConsts.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          onPressed: () =>
                              context.push(RouteConsts.signupRoute),
                        ),
                      ],
                    ),
                    const Gap(20),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
