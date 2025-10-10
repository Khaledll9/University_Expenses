// import 'package:expenses/core/models/expense.dart';
// import 'package:expenses/core/providers/expense_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// void removeExpense(Expense expense, WidgetRef ref, context) {
//   ref.read(expenseNotifierProvider.notifier).deleteExpense(expense.id);
//   ScaffoldMessenger.of(context).clearSnackBars();
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       behavior: SnackBarBehavior.floating,
//       margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       clipBehavior: Clip.none,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       backgroundColor: Theme.of(context).colorScheme.primary,
//       duration: const Duration(seconds: 3),
//       content: Text(
//         'هل انت متاكد من الحذف',
//         style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
//       ),
//       action: SnackBarAction(
//         textColor: Theme.of(context).colorScheme.primaryContainer,
//         label: 'إرحاع',
//         onPressed: () {
//           ref.read(expenseNotifierProvider.notifier).addExpense(expense);
//         },
//       ),
//     ),
//   );
// }
