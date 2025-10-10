import 'package:expenses/core/models/expense.dart';
import 'package:expenses/core/providers/user_notifier.dart';
import 'package:expenses/core/widgets/my_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyTransactionListView extends ConsumerWidget {
  const MyTransactionListView({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;

  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singInUser = ref
        .watch(userNotifierNotifierProvider.notifier)
        .singInUser;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          if (singInUser != null && singInUser.isAdmin) {
            return Dismissible(
              key: ValueKey(expenses[index].id),
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade500,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.only(left: 6, bottom: 12),
              ),
              child: MyTransaction(expense: expenses[index]),

              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
            );
          }

          return MyTransaction(expense: expenses[index]);
        },
      ),
    );
  }
}
