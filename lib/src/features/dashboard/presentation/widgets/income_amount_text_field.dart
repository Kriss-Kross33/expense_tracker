part of '../pages/dashboard_screen.dart';

class _IncomeAmountTextField extends StatelessWidget {
  const _IncomeAmountTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeFormCubit, IncomeFormState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
                textFieldkey: const Key('__income_amount_text_field'),
                isValid: state.amount.displayError != null ? false : null,
                labelText: 'Amount',
                keyboardType: TextInputType.number,
                errorText:
                    state.amount.displayError != null ? 'invalid amount' : null,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context.read<IncomeFormCubit>().amountChanged(
                          double.parse(value),
                        );
                  }
                }),
            SizedBox(
              child: state.amount.displayError == null
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Invalid amount',
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
