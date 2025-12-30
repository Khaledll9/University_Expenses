import 'package:expenses/features/home/models/expense.dart';
import 'package:expenses/features/home/models/user.dart';
import 'package:expenses/features/home/view_model/expense_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpenseState {
  final bool isExpense;
  final bool isStudent;
  final DateTime selectedDate;
  final String studentName;
  final String? errorMessage;
  final bool isSuccess;

  AddExpenseState({
    required this.isExpense,
    required this.isStudent,
    required this.selectedDate,
    required this.studentName,
    this.errorMessage,
    this.isSuccess = false,
  });

  AddExpenseState copyWith({
    bool? isExpense,
    bool? isStudent,
    DateTime? selectedDate,
    String? studentName,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AddExpenseState(
      isExpense: isExpense ?? this.isExpense,
      isStudent: isStudent ?? this.isStudent,
      selectedDate: selectedDate ?? this.selectedDate,
      studentName: studentName ?? this.studentName,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  factory AddExpenseState.initial() {
    return AddExpenseState(
      isExpense: false,
      isStudent: true,
      selectedDate: DateTime.now(),
      studentName: Students.isNotEmpty ? Students.first : '',
    );
  }
}

class AddExpenseViewModel extends Notifier<AddExpenseState> {
  @override
  AddExpenseState build() {
    return AddExpenseState.initial();
  }

  void toggleExpenseType() {
    state = state.copyWith(isExpense: !state.isExpense);
  }

  void toggleUserType() {
    state = state.copyWith(isStudent: !state.isStudent);
  }

  void updateDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void updateStudentName(String? name) {
    if (name != null) {
      state = state.copyWith(studentName: name);
    }
  }

  bool submitExpense({
    required String titleInput,
    required String amountInput,
    required String noteInput,
  }) {
    final enteredAmount = int.tryParse(amountInput);

    if (enteredAmount == null || enteredAmount <= 0) {
      return false;
    }

    final title = titleInput.trim().isEmpty ? state.studentName : titleInput;

    final expense = Expense(
      isStudent: state.isStudent,
      isExpense: state.isExpense,
      title: title,
      id: uuid.v4().substring(0, 8),
      note: noteInput,
      amount: amountInput,
      date: state.selectedDate.toString().substring(0, 10),
    );

    // Using ref.read to interact with other providers is allowed in Notifier
    ref.read(expenseNotifierProvider.notifier).addExpense(expense);

    return true;
  }
}

final addExpenseViewModelProvider =
    NotifierProvider<AddExpenseViewModel, AddExpenseState>(
      () => AddExpenseViewModel(),
    );
