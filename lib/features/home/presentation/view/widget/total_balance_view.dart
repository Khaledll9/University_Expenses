import 'package:expenses/features/home/models/expense.dart';
import 'package:expenses/features/home/view_model/expense_notifier.dart';
import 'package:expenses/features/home/presentation/view/widget/money_card.dart';
import 'package:expenses/features/home/presentation/view/widget/my_transaction_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/utils/shared_preferences_singleton.dart';

class TotalBalanceView extends ConsumerWidget {
  const TotalBalanceView({super.key, required this.expenses});
  static const String routeName = 'MyPaymentView';
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = Prefs.getBool(kIsAdmin);

    int getIncome(List<Expense> expenses) {
      int totalIncome = 0;
      for (var expense in expenses) {
        if (!expense.isExpense) {
          totalIncome += int.parse(expense.amount);
        }
      }
      return totalIncome;
    }

    int getExpense(List<Expense> expenses) {
      int totalExpense = 0;
      for (var expense in expenses) {
        if (expense.isExpense) {
          totalExpense += int.parse(expense.amount);
        }
      }
      return totalExpense;
    }

    List<Expense> getTotalExpense(List<Expense> expenses) {
      final singInStudent = Prefs.getName(kUserName);

      List<Expense> filteredExpenses = expenses
          .where(
            (expense) => expense.title == singInStudent || !expense.isStudent,
          )
          .toList();
      return filteredExpenses;
    }

    int totalIncomes = getIncome(expenses);
    int totalExpenses = getExpense(expenses);
    int getBalance() {
      return totalIncomes - totalExpenses;
    }

    final singInStudentExpenses = getTotalExpense(expenses);
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

    Widget mainContent = Expanded(
      child: Center(
        child: Text(
          "لا يوجد ايداعات بعد...",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );

    if (singInStudentExpenses.isNotEmpty || isAdmin) {
      mainContent = Expanded(
        child: MyTransactionListView(
          expenses: isAdmin ? expenses : singInStudentExpenses,
          onRemoveExpense: removeExpense,
        ),
      );
    }

    return Column(
      children: [
        MoneyCard(
          balance: formatterNumber.format(getBalance()),
          expense: formatterNumber.format(totalExpenses),
          income: formatterNumber.format(totalIncomes),
          expenseName: 'الخرج',
          incomeName: 'الدخل',
          incomeIcon: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowUpDouble,
            color: Colors.green,
          ),
          expenseIcon: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowDownDouble,

            color: Colors.red,
          ),
          cardName: 'الاجمالي',
        ),
        mainContent,
      ],
    );
  }
}
