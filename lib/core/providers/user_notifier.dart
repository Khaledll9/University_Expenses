import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/core/repositories/user_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

class UserNotifierNotifier extends Notifier<List<User>> {
  final _userRepositories = UserRepositories();
  User? singInUser;

  @override
  List<User> build() {
    return state = [];
  }

  Future<List<User>> getUsers() async {
    state = await _userRepositories.getUsers();
    return state;
  }

  Future<void> getSingleUser(String userId) async {
    singInUser = await _userRepositories.getSingleUser(userId);
  }

  Stream<QuerySnapshot> getUsersSnapshot() {
    return _userRepositories.getUsersSnapshot();
  }

  Future<void> addUser(User user) async {
    await _userRepositories.addUser(user);
    state = await _userRepositories.getUsers();
  }

  Future<void> deleteUser(String userId) async {
    await _userRepositories.deleteUser(userId);
  }

  Future<void> updateUser(User user) async {
    await _userRepositories.updateUser(user);
  }
}

final userNotifierNotifierProvider =
    NotifierProvider<UserNotifierNotifier, List<User>>(
      () => UserNotifierNotifier(),
    );
