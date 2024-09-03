import 'dart:math';

import 'package:collection/collection.dart';
import 'package:expense_api/expense_api.dart';
import 'package:expense_track/src/common/widgets/empty_state.dart';
import 'package:expense_track/src/common/widgets/error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../common/blocs/expense_cubit/expense_cubit.dart';

class ExpenditureListView extends StatelessWidget {
  const ExpenditureListView({super.key});

  Color _getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseApiCubit, ExpenseApiState>(
      builder: (context, state) {
        if (state.status == ExpenseApiStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == ExpenseApiStatus.success) {
          if (state.expenses.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Center(child: EmptyState()),
            );
          }
          final groupedExpenditures = groupBy(
            state.expenses,
            (Expense e) => e.category,
          );

          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: groupedExpenditures.length,
              itemBuilder: (context, index) {
                final category = groupedExpenditures.keys.elementAt(index);
                final expenditures = groupedExpenditures[category]!;
                final categoryColor = _getRandomColor();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 5),
                      child: Text(
                        category,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    ...expenditures.map((expenditure) {
                      final isNewItem =
                          expenditure.id == state.expenses.last.id;
                      final itemColor = _getRandomColor();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Slidable(
                          key: Key(expenditure.id ?? ''),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  context
                                      .read<ExpenseApiCubit>()
                                      .deleteExpense(expenditure.id!);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: itemColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              leading: CircleAvatar(
                                backgroundColor: itemColor,
                                child: Text(
                                  expenditure.nameOfItem[0].toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              title: Text(
                                expenditure.nameOfItem,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              subtitle: Text(
                                  'Amount: \$${expenditure.estimatedAmount.toStringAsFixed(2)}'),
                              trailing: Text(
                                expenditure.category,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          );
        } else if (state.status == ExpenseApiStatus.failure) {
          return const Center(child: ErrorState());
        }
        return const Center(child: Text('No data available'));
      },
    );
  }
}
