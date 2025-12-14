import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/features/home/models/user.dart';

class UserRepositories {
  final _fireStore = FirebaseFirestore.instance;
  static const _usersCollectionPath = 'users';

  // Stream<List<Expense>> getExpensesStream() {
  //   return _fireStore.collection(_expenseCollectionPath).snapshots().map((
  //     snapshot,
  //   ) {
  //     return snapshot.docs
  //         .map((doc) => Expense.formFirebase(doc.data()))
  //         .toList();
  //   });
  // }
  // Future<List<Expense>> getExpenses() async {
  // late List<Expense> tempList = [];
  // final data = await _fireStore.collection(_expenseCollectionPath).get();
  // for (var element in data.docs) {
  //   tempList.add(Expense.formFirebase(element.data()));
  // }
  //   return data.docs.map((doc) => Expense.formFirebase(doc.data())).toList();
  // }

  Future<List<User>> getUsers() async {
    final snapshot = await _fireStore.collection(_usersCollectionPath).get();
    return snapshot.docs.map((doc) => User.formFirebase(doc.data())).toList();
  }

  Future<User> getSingleUser(String userId) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    return User.formFirebase(docSnapshot.data()!);
  }

  Stream<QuerySnapshot> getUsersSnapshot() {
    return _fireStore.collection(_usersCollectionPath).snapshots();
  }

  Future<void> addUser(User user) async {
    await _fireStore.collection(_usersCollectionPath).doc(user.id).set({
      'id': user.id,
      'name': user.name,
      'isAdmin': user.isAdmin,
      'number': user.number,
      'isAccepted': user.isAccepted,
    });
  }

  Future<void> updateUser(User user) async {
    await _fireStore.collection(_usersCollectionPath).doc(user.id).set({
      'id': user.id,
      'name': user.name,
      'isAdmin': user.isAdmin,
      'number': user.number,
      'isAccepted': true,
    });
  }

  // Future<void> updateUser(User user) async {
  //   await _fireStore
  //       .collection(_usersCollectionPath)
  //       .doc(user.id)
  //       .update(user.toFirebase());
  // }

  Future<void> deleteUser(String id) async {
    await _fireStore.collection(_usersCollectionPath).doc(id).delete();
  }
}
