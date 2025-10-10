import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

class ShowStudentsNotifier extends Notifier<String> {
  @override
  String build() {
    return Students.first;
  }

  void changeStudent(String student) {
    state = student;
  }
}

final showStudentsNotifierProvider =
    NotifierProvider<ShowStudentsNotifier, String>(
      () => ShowStudentsNotifier(),
    );
