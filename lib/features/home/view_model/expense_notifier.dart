import 'package:expenses/features/home/models/expense.dart';
import 'package:expenses/features/home/repositories/expense_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends Notifier<List<Expense>> {
  final expenseRepositories = ExpenseRepositories();

  @override
  List<Expense> build() {
    return [];
  }

  Future<void> getExpense() async {
    state = await expenseRepositories.getExpenses();
  }

  Future<void> addExpense(Expense expense) async {
    await expenseRepositories.addExpense(expense);
    state = await expenseRepositories.getExpenses();
  }

  Stream<List<Expense>> getExpenseSnapshot() {
    return expenseRepositories.getExpensesStream();
  }

  Future<void> deleteExpense(String expenseId) async {
    await expenseRepositories.deleteExpense(expenseId);
    state = await expenseRepositories.getExpenses();
  }
}

final expenseNotifierProvider =
    NotifierProvider<ExpenseNotifier, List<Expense>>(() => ExpenseNotifier());
