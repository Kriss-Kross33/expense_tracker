part of '../pages/dashboard_screen.dart';

class _AddExpenseButton extends StatelessWidget {
  const _AddExpenseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConsts.violet,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: !state.isValid
              ? null
              : () {
                  context.read<ExpenseApiCubit>().addExpense(
                          expense: Expense(
                        nameOfItem: state.nameOfItem.value,
                        estimatedAmount: state.amount.value,
                        category: state.category.value,
                      ));
                  Navigator.pop(context);
                },
          child:
              const Text('Add Expense', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}
