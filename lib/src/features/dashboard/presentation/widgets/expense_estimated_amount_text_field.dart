part of '../pages/dashboard_screen.dart';

class _ExpenseEstimatedAmountTextField extends StatelessWidget {
  const _ExpenseEstimatedAmountTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return CustomTextField(
          textFieldkey: const Key('__expense_estimated_amount_text_field'),
          isValid: state.amount.displayError != null ? false : null,
          labelText: 'Estimated Amount',
          errorText:
              state.amount.displayError != null ? 'invalid amount' : null,
          onChanged: (value) => context.read<ExpenseFormCubit>().amountChanged(
                double.parse(value),
              ),
        );
      },
    );
  }
}
