import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/core/core.dart';
import 'package:expense_track/src/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            create: (context) => SignupCubit(
              expenseApiRepository: context.read<ExpenseApiRepository>(),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Sign up',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                    const Gap(10),
                    Center(
                      child: Text(
                        'Fill your details to create an account',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                    const Gap(20),
                    SignupForm(
                      constraints: constraints,
                      key: const Key('__signupForm'),
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        TextButton(
                          child: Text(
                            'Log in',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorConsts.primaryColor,
                                    ),
                          ),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ],
                    ),
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
