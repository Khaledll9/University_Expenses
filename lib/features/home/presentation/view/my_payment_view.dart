import 'package:expenses/core/constants.dart';
import 'package:expenses/core/utils/shared_preferences_singleton.dart';
import 'package:expenses/features/home/models/expense.dart';
import 'package:expenses/features/home/view_model/expense_notifier.dart';
import 'package:expenses/features/home/presentation/view/widget/money_card.dart';
import 'package:expenses/features/home/presentation/view/widget/my_transaction_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class MyPaymentView extends ConsumerWidget {
  const MyPaymentView({super.key, required this.expenses});
  static const String routeName = 'MyPaymentView';
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singInStudent = Prefs.getName(kUserName);
    void removeExpense(Expense expense) {
      ref.read(expenseNotifierProvider.notifier).deleteExpense(expense.id);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          clipBehavior: Clip.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 3),
          content: Text(
            'هل انت متاكد من الحذف',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          action: SnackBarAction(
            textColor: Theme.of(context).colorScheme.primaryContainer,
            label: 'إرجاع',
            onPressed: () {
              ref.read(expenseNotifierProvider.notifier).addExpense(expense);
            },
          ),
        ),
      );
    }

    List<Expense> getExpensesOfStudent(List<Expense> expenses) {
      List<Expense> studentShowExpense = [];
      for (final expense in expenses) {
        if (expense.title == singInStudent) {
          studentShowExpense.add(expense);
        }
      }
      return studentShowExpense;
    }

    final studentExpenses = getExpensesOfStudent(expenses);

    int getTotalAmountOfStudent(List<Expense> expenses) {
      int totalAmount = 0;
      for (final expense in expenses) {
        if (expense.isExpense) {
          totalAmount -= int.parse(expense.amount);
        }
        if (!expense.isExpense) {
          totalAmount += int.parse(expense.amount);
        }
      }
      return totalAmount;
    }

    final studentPay = getTotalAmountOfStudent(studentExpenses);

    Widget mainContent = Expanded(
      child: Center(
        child: Text(
          'لايوجد ايداعات بعد...',
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
    if (studentExpenses.isNotEmpty) {
      mainContent = Expanded(
        child: MyTransactionListView(
          expenses: studentExpenses,
          onRemoveExpense: removeExpense,
        ),
      );
    }

    return Column(
      children: [
        MoneyCard(
          balance: formatterNumber.format(50000),
          expense: formatterNumber.format(50000 - studentPay),
          income: formatterNumber.format(studentPay),
          expenseName: 'كم باقي',
          incomeName: 'كم دفعت',
          incomeIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedMoneyReceiveFlow02,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          expenseIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedMoneySendFlow02,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          cardName: singInStudent,
        ),
        mainContent,
      ],
    );
  }
}
