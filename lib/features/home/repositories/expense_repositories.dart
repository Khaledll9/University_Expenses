import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/features/home/models/expense.dart';

class ExpenseRepositories {
  final _fireStore = FirebaseFirestore.instance;
  static const _expenseCollectionPath = 'expenses';

  Stream<List<Expense>> getExpensesStream() {
    return _fireStore
        .collection(_expenseCollectionPath)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Expense.formFirebase(doc.data()))
              .toList();
        });
  }
  // Future<List<Expense>> getExpenses() async {
  // late List<Expense> tempList = [];
  // final data = await _fireStore.collection(_expenseCollectionPath).get();
  // for (var element in data.docs) {
  //   tempList.add(Expense.formFirebase(element.data()));
  // }
  //   return data.docs.map((doc) => Expense.formFirebase(doc.data())).toList();
  // }

  Future<List<Expense>> getExpenses() async {
    final snapshot = await _fireStore.collection(_expenseCollectionPath).get();
    return snapshot.docs
        .map((doc) => Expense.formFirebase(doc.data()))
        .toList();
  }

  Stream<QuerySnapshot> getExpensesSnapshot() {
    return _fireStore.collection(_expenseCollectionPath).snapshots();
  }

  Future<void> addExpense(Expense expense) async {
    await _fireStore.collection(_expenseCollectionPath).doc(expense.id).set({
      'title': expense.title,
      'id': expense.id,
      'amount': expense.amount,
      'date': expense.date.substring(0, 10),
      'note': expense.note,
      'isExpense': expense.isExpense,
      'isStudent': expense.isStudent,
    });
  }

  Future<void> updateExpense(Expense expense) async {
    await _fireStore
        .collection(_expenseCollectionPath)
        .doc(expense.id)
        .update(expense.toFirebase());
  }

  Future<void> deleteExpense(String id) async {
    await _fireStore.collection(_expenseCollectionPath).doc(id).delete();
  }
}
