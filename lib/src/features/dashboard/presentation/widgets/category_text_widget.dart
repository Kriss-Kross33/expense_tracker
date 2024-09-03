part of '../pages/dashboard_screen.dart';

class _CategoryTextField extends StatelessWidget {
  const _CategoryTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        return CustomTextField(
          textFieldkey: const Key('__estimated_amount_text_field'),
          isValid: state.category.displayError != null ? false : null,
          labelText: 'Category',
          errorText:
              state.category.displayError != null ? 'invalid category' : null,
          onChanged: (value) =>
              context.read<ExpenseFormCubit>().categoryChanged(value),
        );
      },
    );
  }
}
