part of '../pages/dashboard_screen.dart';

class _IncomeSourceTextField extends StatelessWidget {
  const _IncomeSourceTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeFormCubit, IncomeFormState>(
      buildWhen: (previous, current) =>
          previous.nameOfRevenue != current.nameOfRevenue,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              textFieldkey: const Key('__income_source_text_field'),
              isValid: state.nameOfRevenue.displayError != null ? false : null,
              labelText: 'Source',
              onChanged: (value) =>
                  context.read<IncomeFormCubit>().nameOfRevenueChanged(
                        value,
                      ),
            ),
            SizedBox(
              child: state.nameOfRevenue.displayError == null
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Invalid source',
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
