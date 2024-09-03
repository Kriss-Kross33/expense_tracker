part of '../pages/dashboard_screen.dart';

class AddIncomeButton extends StatelessWidget {
  const AddIncomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeFormCubit, IncomeFormState>(
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
                  context.read<ExpenseApiCubit>().addIncome(
                          income: Income(
                        nameOfRevenue: state.nameOfRevenue.value,
                        amount: state.amount.value,
                      ));
                  Navigator.pop(context);
                },
          child:
              const Text('Add Income', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}
