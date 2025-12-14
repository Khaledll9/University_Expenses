import 'package:expenses/features/home/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
