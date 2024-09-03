part of '../pages/dashboard_screen.dart';

class _AddIncomeForm extends StatelessWidget {
  const _AddIncomeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncomeFormCubit(),
      child: Builder(builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Income',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _IncomeSourceTextField(),
              SizedBox(height: 16),
              _IncomeAmountTextField(),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: AddIncomeButton(),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }
}
