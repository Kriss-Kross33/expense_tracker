part of '../pages/dashboard_screen.dart';

class _IncomeHistoryList extends StatelessWidget {
  const _IncomeHistoryList({super.key});

  Color _getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocBuilder<ExpenseApiCubit, ExpenseApiState>(
        builder: (context, state) {
          if (state.status == ExpenseApiStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ExpenseApiStatus.success) {
            if (state.incomeList.isEmpty) {
              return Center(
                child: Image.asset(
                  'assets/images/empty_state.png',
                  width: 100,
                  height: 100,
                ),
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.incomeList.length,
                    itemBuilder: (context, index) {
                      final categoryColor = _getRandomColor();
                      final income = state.incomeList[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Slidable(
                          key: Key(income.id ?? ''),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  context
                                      .read<ExpenseApiCubit>()
                                      .deleteIncome(income.id!);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: BlocBuilder<ThemeCubit, ThemeState>(
                            builder: (context, themeState) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: themeState.themeMode ==
                                          AppThemeMode.lightMode
                                      ? Colors.grey[200]
                                      : Colors.grey[900],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      left: 0.0, right: 0.0),
                                  leading: CircleAvatar(
                                    backgroundColor: categoryColor,
                                    child: Text(
                                      income.nameOfRevenue[0].toUpperCase(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  title: Text(
                                    income.nameOfRevenue,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: themeState.themeMode ==
                                                  AppThemeMode.lightMode
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  subtitle: Text(
                                      'GH¢${income.amount.toStringAsFixed(2)}'),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(20),
              ],
            );
          } else if (state.status == ExpenseApiStatus.failure) {
            return const Center(
              child: ErrorState(),
            );
          }
          return const Center(
            child: EmptyState(),
          );
        },
      ),
    );
  }
}
