import 'package:expenses/core/models/expense.dart';
import 'package:expenses/core/providers/expense_notifier.dart';
import 'package:expenses/core/providers/sing_in_student_notifier.dart';
import 'package:expenses/core/providers/user_notifier.dart';
import 'package:expenses/core/widgets/money_card.dart';
import 'package:expenses/core/widgets/my_transaction_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class TotalBalanceView extends ConsumerWidget {
  const TotalBalanceView({super.key, required this.expenses});
  static const String routeName = 'MyPaymentView';
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singInUser = ref
        .watch(userNotifierNotifierProvider.notifier)
        .singInUser;
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
      final singInStudent = ref.watch(singInStudentNotifierProvider);

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
            label: 'إرحاع',
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

    if (singInStudentExpenses.isNotEmpty) {
      mainContent = Expanded(
        child: MyTransactionListView(
          expenses: singInUser != null && singInUser.isAdmin
              ? expenses
              : singInStudentExpenses,
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
