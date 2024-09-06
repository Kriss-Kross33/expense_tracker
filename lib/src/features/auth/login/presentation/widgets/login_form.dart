import 'package:expense_track/src/common/common.dart';
import 'package:expense_track/src/core/core.dart';
import 'package:expense_track/src/features/auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

part 'email_text_field.dart';
part 'login_button.dart';
part 'password_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _EmailTextField(),
        const Gap(15),
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
        const Gap(44),
        _LoginButton(constraints: constraints),
      ],
    );
  }
}
