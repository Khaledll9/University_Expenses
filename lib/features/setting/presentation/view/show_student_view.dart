import 'package:expenses/core/models/user.dart';
import 'package:expenses/core/providers/show_students_notifier.dart';
import 'package:expenses/core/widgets/drop_down_menu_list.dart';
import 'package:expenses/features/setting/presentation/view/widget/show_student_expense_view.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowStudentView extends ConsumerWidget {
  const ShowStudentView({super.key});

  static const routeName = 'ShowStudentView';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جميع الطلاب'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropDownMenuList(
                  studentList: Students,
                  studentName: ref.watch(showStudentsNotifierProvider),
                  onChange: (value) {
                    if (value == null) {
                      return;
                    }
                    ref
                        .read(showStudentsNotifierProvider.notifier)
                        .changeStudent(value);
                  },
                ),

                const SizedBox(height: 40),
                CustomButton(
                  buttonName: 'عرض البيانات',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ShowStudentExpenseView.routeName,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
