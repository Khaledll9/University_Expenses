import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

class SingInStudentNotifier extends Notifier<String> {
  @override
  String build() {
    return Students.first;
  }

  void changeStudent(String student) {
    state = student;
  }
}

final singInStudentNotifierProvider =
    NotifierProvider<SingInStudentNotifier, String>(
      () => SingInStudentNotifier(),
    );
