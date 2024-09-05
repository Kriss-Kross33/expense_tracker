import 'dart:math';

import 'package:expense_api/expense_api.dart';
import 'package:expense_track/src/common/blocs/expense_cubit/expense_cubit.dart';
import 'package:expense_track/src/common/common.dart';
import 'package:expense_track/src/common/widgets/empty_state.dart';
import 'package:expense_track/src/common/widgets/error_state.dart';
import 'package:expense_track/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../cubits/cubits.dart';

part '../widgets/add_expense_button.dart';
part '../widgets/add_expense_form.dart';
part '../widgets/add_income_button.dart';
part '../widgets/add_income_form.dart';
part '../widgets/category_text_widget.dart';
part '../widgets/expense_estimated_amount_text_field.dart';
part '../widgets/expense_name_text_field.dart';
part '../widgets/income_amount_text_field.dart';
part '../widgets/income_history_list.dart';
part '../widgets/income_source_text_field.dart';
// part '../widgets/last_five_expenditure_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    context.read<ExpenseApiCubit>().getExpenses();
    context.read<ExpenseApiCubit>().getIncome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(top: 60, left: 14, right: 14),
          child: Column(
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/profile_pic.png'),
                    radius: 20,
                  ),
                  Gap(10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Kwame Fosu',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        height: 154,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConsts.violet,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Total Balance',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    BlocBuilder<ExpenseApiCubit,
                                        ExpenseApiState>(
                                      builder: (context, state) {
                                        return Text(
                                          '${state.balance < 0 ? '-' : ''}GHs ${state.balance.abs()}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Gap(20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 50),
                                        child: Text(
                                          'Income',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: const Icon(
                                                    Icons.arrow_outward,
                                                    color: ColorConsts.violet,
                                                    size: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(10),
                                            BlocBuilder<ExpenseApiCubit,
                                                ExpenseApiState>(
                                              builder: (context, state) {
                                                return Text(
                                                  'GH¢${state.totalIncome}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 1,
                                  height: 50,
                                  child: VerticalDivider(
                                    color: Colors.white30,
                                    width: 1,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 50),
                                        child: Text(
                                          'Expense',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Transform.rotate(
                                                angle: 3.14159,
                                                child: const Icon(
                                                  Icons.arrow_outward,
                                                  size: 14,
                                                  color: ColorConsts.violet,
                                                ),
                                              ),
                                            ),
                                            const Gap(10),
                                            BlocBuilder<ExpenseApiCubit,
                                                ExpenseApiState>(
                                              builder: (context, state) {
                                                return Text(
                                                  'GH¢${state.totalExpense}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () =>
                                    _showAddIncomeBottomSheet(context),
                                icon: const Icon(Icons.add),
                                label: const Text('Add Income'),
                              ),
                            ),
                          ),
                          const Gap(30),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () =>
                                    _showAddExpenseBottomSheet(context),
                                icon: const Icon(Icons.add),
                                label: const Text('Add Expense'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, themestate) {
                          return Container(
                            decoration: BoxDecoration(
                              color:
                                  themestate.themeMode == AppThemeMode.lightMode
                                      ? Colors.grey[200]
                                      : Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                BlocBuilder<ExpenseApiCubit, ExpenseApiState>(
                              builder: (context, state) {
                                final totalIncome = state.totalIncome;
                                final totalExpense = state.totalExpense;
                                final total = totalIncome + totalExpense;
                                final incomePercentage = total > 0
                                    ? (totalIncome / total * 100).round()
                                    : 0;
                                final expensePercentage = total > 0
                                    ? (totalExpense / total * 100).round()
                                    : 0;

                                return SfCircularChart(
                                  title: ChartTitle(
                                    text: 'Income vs Expenses',
                                    textStyle: TextStyle(
                                      color: themestate.themeMode ==
                                              AppThemeMode.lightMode
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  legend: const Legend(
                                      isVisible: true,
                                      position: LegendPosition.bottom),
                                  series: <CircularSeries>[
                                    DoughnutSeries<FinancialData, String>(
                                      innerRadius: '70%',
                                      radius: '95%',
                                      dataSource: [
                                        FinancialData(
                                            category: 'Income',
                                            percentage: incomePercentage,
                                            color: themestate.themeMode ==
                                                    AppThemeMode.lightMode
                                                ? const Color(0xFF0e6085)
                                                : const Color(0xFF0e6085)),
                                        FinancialData(
                                            category: 'Expenses',
                                            percentage: expensePercentage,
                                            color: themestate.themeMode ==
                                                    AppThemeMode.lightMode
                                                ? const Color(0xFFdf6188)
                                                : const Color(0xFFdf6188)),
                                      ],
                                      xValueMapper: (FinancialData data, _) =>
                                          data.category,
                                      yValueMapper: (FinancialData data, _) =>
                                          data.percentage,
                                      pointColorMapper:
                                          (FinancialData data, _) => data.color,
                                      dataLabelMapper: (FinancialData data,
                                              _) =>
                                          '${data.category}\n${data.percentage}%',
                                      dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        labelPosition:
                                            ChartDataLabelPosition.outside,
                                        textStyle: TextStyle(
                                          color: themestate.themeMode ==
                                                  AppThemeMode.lightMode
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                  annotations: <CircularChartAnnotation>[
                                    CircularChartAnnotation(
                                      widget: Container(
                                        child: Text(
                                          'Total\nGH¢${total.toStringAsFixed(2)}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: themestate.themeMode ==
                                                    AppThemeMode.lightMode
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Income History',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(10),
                      const _IncomeHistoryList()
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddExpenseBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const _AddExpenseForm(),
        );
      },
    );
  }

  void _showAddIncomeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const _AddIncomeForm(),
          );
        });
      },
    );
  }
}

class ChartData {
  final String category;
  final int percentage;
  final Color color;

  ChartData(this.category, this.percentage, this.color);
}

class FinancialData {
  FinancialData(
      {required this.category, required this.percentage, required this.color});
  final String category;
  final int percentage;
  final Color color;
}


//  SfCircularChart(
//                             title: ChartTitle(
//                               text: 'Income vs Expenses',
//                               textStyle: const TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             legend: const Legend(
//                                 isVisible: true,
//                                 position: LegendPosition.bottom),
//                             series: <CircularSeries>[
//                               DoughnutSeries<FinancialData, String>(
//                                 dataSource: [
//                                   FinancialData(
//                                       'Income', 60, const Color(0xFF0e6085)),
//                                   FinancialData(
//                                       'Expenses', 40, const Color(0xFFdf6188)),
//                                 ],
//                                 xValueMapper: (FinancialData data, _) =>
//                                     data.category,
//                                 yValueMapper: (FinancialData data, _) =>
//                                     data.value,
//                                 pointColorMapper: (FinancialData data, _) =>
//                                     data.color,
//                                 dataLabelSettings: DataLabelSettings(
//                                   isVisible: true,
//                                   labelPosition: ChartDataLabelPosition.outside,
//                                   builder: (data, point, series, pointIndex,
//                                       seriesIndex) {
//                                     return Container(
//                                       padding: const EdgeInsets.all(4),
//                                       child: Text(
//                                         '${(data as FinancialData).category}\n${(data).value}%',
//                                         textAlign: TextAlign.center,
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                             annotations: <CircularChartAnnotation>[
//                               CircularChartAnnotation(
//                                 widget: Container(
//                                   child: const Text(
//                                     'Total\n\$1000',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),