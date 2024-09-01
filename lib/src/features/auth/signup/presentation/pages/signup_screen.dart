import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/core/core.dart';
import 'package:expense_track/src/features/auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

part '../widgets/confirm_password_text_field.dart';
part '../widgets/email_text_field.dart';
part '../widgets/first_name_text_field.dart';
part '../widgets/password_text_field.dart';
part '../widgets/signup_button.dart';

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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cerene',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        Text(
                          'Begin your journey to emotional wellness',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const Gap(31),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'First name *',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                        const Gap(4),
                        const _FirstNameTextField(),
                        const Gap(19),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Email *',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                        const Gap(4),
                        const _EmailTextField(),
                        const Gap(19),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Password *',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                        const Gap(4),
                        const _PasswordTextField(),
                        const Gap(10),
                        Text(
                          'NB: Your password should have a minimum of six(6) characters',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                        const Gap(20),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Retype password *',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                        const Gap(4),
                        const _ConfirmPasswordTextField(),
                        const Gap(25),
                        Row(
                          children: [
                            Flexible(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: 'I have read and accept the ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 11,
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                                TextSpan(
                                  text: ' of using Cerene',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 11,
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                              ])),
                            )
                          ],
                        ),
                        const Gap(15),
                        _SignupButton(constraints: constraints),
                        const Gap(13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                            TextButton(
                              child: Text(
                                'Log in',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
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
