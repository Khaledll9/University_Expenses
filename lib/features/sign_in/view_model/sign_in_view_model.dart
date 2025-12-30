import 'package:expenses/core/constants.dart';
import 'package:expenses/core/providers/users_notifier.dart';
import 'package:expenses/core/utils/shared_preferences_singleton.dart';
import 'package:expenses/features/home/models/expense.dart'; // for uuid
import 'package:expenses/features/home/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInState {
  final String studentName;
  final bool isAdmin;

  SignInState({required this.studentName, required this.isAdmin});

  SignInState copyWith({String? studentName, bool? isAdmin}) {
    return SignInState(
      studentName: studentName ?? this.studentName,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  factory SignInState.initial() {
    return SignInState(
      studentName: Students.isNotEmpty ? Students.first : '',
      isAdmin: false,
    );
  }
}

class SignInViewModel extends Notifier<SignInState> {
  @override
  SignInState build() {
    return SignInState.initial();
  }

  void changeStudent(String name) {
    state = state.copyWith(studentName: name);
    // Also updating Prefs here if needed, or wait until submit?
    // The original code updated Prefs immediately: Prefs.setName(kUserName, value);
    Prefs.setName(kUserName, name);
  }

  void toggleAdmin() {
    state = state.copyWith(isAdmin: !state.isAdmin);
  }

  // Returns the ID if successful, null otherwise
  Future<String?> signIn(String phoneNumber) async {
    final enteredAmount = int.tryParse(phoneNumber);
    if (enteredAmount == null || enteredAmount <= 0) {
      return null;
    }

    final id = uuid.v4().substring(0, 8);
    final user = User(
      id: id,
      name: state.studentName,
      isAdmin: state.isAdmin,
      number: phoneNumber,
      isAccepted: false,
    );

    Prefs.setBool(kIsAdmin, state.isAdmin);
    Prefs.setBool(kIsSingInPressed, true);

    // We interact with the repo/global notifier
    await ref.read(usersNotifierNotifierProvider.notifier).addUser(user);

    return id;
  }
}

final signInViewModelProvider = NotifierProvider<SignInViewModel, SignInState>(
  () => SignInViewModel(),
);
