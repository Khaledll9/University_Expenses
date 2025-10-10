import 'package:expenses/core/models/expense.dart';
import 'package:expenses/core/providers/expense_notifier.dart';
import 'package:expenses/core/providers/show_students_notifier.dart';
import 'package:expenses/core/widgets/money_card.dart';
import 'package:expenses/core/widgets/my_transaction_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class ShowStudentExpenseView extends ConsumerWidget {
  const ShowStudentExpenseView({super.key});

  static const String routeName = 'ShowStudentExpenseView';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showStudent = ref.watch(showStudentsNotifierProvider);
    // final expenses = ref.watch(expenseNotifierProvider);

    var studentPay = 0;

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

    List<Expense> getExpensesOfStudent(List<Expense> expenses) {
      List<Expense> studentShowExpense = [];
      for (var expense in expenses) {
        if (expense.title == showStudent) {
          studentShowExpense.add(expense);
        }
      }
      return studentShowExpense;
    }

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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder(
          stream: ref
              .read(expenseNotifierProvider.notifier)
              .getExpenseSnapshot(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'هناك مشكلة في تلقي البيانات',
                  style: TextStyle(fontSize: 24),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              Column(
                children: [
                  const SizedBox(height: 30),
                  MoneyCard(
                    balance: formatterNumber.format(50000),
                    expense: formatterNumber.format(50000),
                    income: formatterNumber.format(0),
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
                    cardName: showStudent,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "لا يوجد ايداعات بعد...",
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            final expenses = snapshot.data!;
            final studentExpenses = getExpensesOfStudent(expenses);
            studentPay = getTotalAmountOfStudent(studentExpenses);

            return Column(
              children: [
                const SizedBox(height: 30),
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
                  cardName: showStudent,
                ),
                Expanded(
                  child: MyTransactionListView(
                    expenses: studentExpenses,
                    onRemoveExpense: removeExpense,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
