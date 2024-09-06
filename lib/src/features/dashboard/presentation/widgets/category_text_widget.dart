part of '../pages/dashboard_screen.dart';

class _CategoryTextField extends StatefulWidget {
  const _CategoryTextField({super.key});

  @override
  State<_CategoryTextField> createState() => _CategoryTextFieldState();
}

class _CategoryTextFieldState extends State<_CategoryTextField> {
  final categoryController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, categoryState) {
        categoryController.text = categoryState.selectedCategory ?? '';
      },
      builder: (context, categoryState) {
        return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
          buildWhen: (previous, current) =>
              previous.category != current.category,
          builder: (context, expenseFormState) {
            return CustomTextField(
              readOnly: true,
              controller: categoryController,
              onTap: () async => await showModalBottomSheet(
                context: context,
                builder: (context) => const _CategoryWidget(),
              ),
              textFieldkey: const Key('__estimated_amount_text_field'),
              isValid:
                  expenseFormState.category.displayError != null ? false : null,
              labelText: 'Category',
              errorText: expenseFormState.category.displayError != null
                  ? 'invalid category'
                  : null,
              onChanged: (value) =>
                  context.read<ExpenseFormCubit>().categoryChanged(value),
            );
          },
        );
      },
    );
  }
}

class _CategoryWidget extends StatefulWidget {
  const _CategoryWidget({super.key});

  @override
  State<_CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<_CategoryWidget> {
  final categories = [
    ('🍔', 'Food'),
    ('🏢', 'Bills'),
    ('🏋️', 'Fitness'),
    ('🎬', 'Entertainment'),
    ('🚗', 'Transport'),
    ('🏠', 'Home'),
    ('👕', 'Clothing'),
    ('📚', 'School'),
    ('🎮', 'Gaming'),
    ('🏥', 'Health'),
    ('🎁', 'Gifts'),
    ('🍻', 'Drinks'),
    ('🍽️', 'Restaurants'),
    ('🛍️', 'Shopping'),
    ('💸', 'Finances'),
    ('🚲', 'Bike'),
    ('🚗', 'Car'),
    ('🚕', 'Taxi'),
    ('🔌', 'Utility'),
    ('🚂', 'Travel'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            'Select Category',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    context
                        .read<CategoryCubit>()
                        .onCategorySelected(category.$2);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            categories[index].$1,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      Text('${categories[index].$1} ${categories[index].$2}'),
                    ],
                  ),
                );
              },
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
