part of '../pages/dashboard_screen.dart';

class _ExpenseNameTextField extends StatelessWidget {
  const _ExpenseNameTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      buildWhen: (previous, current) =>
          previous.nameOfItem != current.nameOfItem,
      builder: (context, state) {
        return CustomTextField(
          textFieldkey: const Key('__expense_name_text_field'),
          isValid: state.nameOfItem.displayError != null ? false : null,
          labelText: 'Name of Item',
          errorText:
              state.nameOfItem.displayError != null ? 'invalid name' : null,
          onChanged: (value) =>
              context.read<ExpenseFormCubit>().nameOfItemChanged(value),
        );
      },
    );
  }
}
