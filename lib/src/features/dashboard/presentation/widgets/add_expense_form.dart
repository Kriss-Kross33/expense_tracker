part of '../pages/dashboard_screen.dart';

class _AddExpenseForm extends StatelessWidget {
  const _AddExpenseForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseFormCubit(),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Add Expense',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            _ExpenseNameTextField(),
            SizedBox(height: 16),
            _ExpenseEstimatedAmountTextField(),
            SizedBox(height: 16),
            _CategoryTextField(),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: _AddExpenseButton(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
