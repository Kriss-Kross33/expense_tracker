import 'package:expense_track/src/common/blocs/expense_cubit/expense_cubit.dart';
import 'package:expense_track/src/features/expenditure/presentation/widgets/expenditure_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/color_consts.dart';

class ExpenditureScreen extends StatefulWidget {
  const ExpenditureScreen({super.key});

  @override
  _ExpenditureScreenState createState() => _ExpenditureScreenState();
}

class _ExpenditureScreenState extends State<ExpenditureScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await context.read<ExpenseApiCubit>().getExpenses();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Expenses',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
                height: 90,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  color: ColorConsts.violet,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Expenditure',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            BlocBuilder<ExpenseApiCubit, ExpenseApiState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    Text(
                                      '\$${state.totalExpense}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(4),
                                    Text(
                                      '/ \$${(state.totalExpense / 12).toStringAsFixed(2)} per month',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.white54),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(16),
              const Flexible(
                child: ExpenditureListView(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
