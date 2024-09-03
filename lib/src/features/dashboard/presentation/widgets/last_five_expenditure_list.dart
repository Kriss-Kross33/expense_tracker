// part of '../pages/dashboard_screen.dart';

// class _LastFiveExpenditureList extends StatefulWidget {
//   const _LastFiveExpenditureList({super.key});

//   @override
//   State<_LastFiveExpenditureList> createState() =>
//       _LastFiveExpenditureListState();
// }

// class _LastFiveExpenditureListState extends State<_LastFiveExpenditureList> {
//   Color _getRandomColor() {
//     return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: BlocBuilder<ExpenseApiCubit, ExpenseApiState>(
//         builder: (context, state) {
//           if (state.status == ExpenseApiStatus.loading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.status == ExpenseApiStatus.success) {
//             if (state.lastFiveExpenses.isEmpty) {
//               return const Center(child: Text('No data available'));
//             }
//             return MediaQuery.removePadding(
//               context: context,
//               removeTop: true,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: state.lastFiveExpenses.length,
//                 itemBuilder: (context, index) {
//                   final categoryColor = _getRandomColor();
//                   final expenditure = state.lastFiveExpenses[index];
//                   final itemColor = categoryColor.withOpacity(0.1);
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 10),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       decoration: BoxDecoration(
//                         color: itemColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ListTile(
//                         contentPadding:
//                             const EdgeInsets.only(left: 0.0, right: 0.0),
//                         leading: CircleAvatar(
//                           backgroundColor: categoryColor,
//                           child: Text(
//                             expenditure.nameOfItem[0].toUpperCase(),
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         title: Text(expenditure.nameOfItem),
//                         subtitle: Text(
//                             'Amount: \$${expenditure.estimatedAmount.toStringAsFixed(2)}'),
//                         trailing: Text(
//                           expenditure.category,
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           } else if (state.status == ExpenseApiStatus.failure) {
//             return Center(child: Text('Error: ${state.errorMessage}'));
//           }
//           return const Center(child: Text('No data available'));
//         },
//       ),
//     );
//   }
// }
