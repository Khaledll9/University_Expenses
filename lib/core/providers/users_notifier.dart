// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expenses/features/home/repositories/user_repositories.dart';

import '../../features/home/models/user.dart';

class UsersNotifierNotifier extends Notifier<List<User>> {
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

  Future<void> setSingleUser(String userId) async {
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

final usersNotifierNotifierProvider =
    NotifierProvider<UsersNotifierNotifier, List<User>>(
      () => UsersNotifierNotifier(),
    );
