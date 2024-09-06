import 'package:expense_track/src/common/common.dart';
import 'package:expense_track/src/core/core.dart';
import 'package:expense_track/src/features/auth/signup/presentation/cubits/cubits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

part 'confirm_password_text_field.dart';
part 'email_text_field.dart';
part 'first_name_text_field.dart';
part 'password_text_field.dart';
part 'signup_button.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Full name',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
          ),
        ),
        const Gap(4),
        const _FirstNameTextField(),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Email',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
          ),
        ),
        const Gap(4),
        const _EmailTextField(),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Password',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
          ),
        ),
        const Gap(4),
        const _PasswordTextField(),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Confirm password',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
          ),
        ),
        const Gap(4),
        const _ConfirmPasswordTextField(),
        const Gap(40),
        _SignupButton(constraints: constraints),
      ],
    );
  }
}
