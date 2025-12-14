import 'dart:developer';

import 'package:expenses/core/constants.dart';
import 'package:expenses/core/utils/shared_preferences_singleton.dart';
import 'package:expenses/features/home/models/expense.dart';
import 'package:expenses/features/home/models/user.dart';
import 'package:expenses/core/providers/users_notifier.dart';
import 'package:expenses/core/widgets/drop_down_menu_list.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/custom_buttom.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/custom_text_field.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/custom_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/sing_in_student_notifier.dart';
import 'widget/waiting_accept_view.dart';

class SingInView extends ConsumerWidget {
  const SingInView({super.key});

  static const String routeName = 'SingInView';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAdmin = false;
    bool isAccepted = false;
    final amountController = TextEditingController();

    String studentName = ref.watch(singInStudentNotifierProvider);

    void submitExpenseData(WidgetRef ref) {
      final enteredAmount = int.tryParse(
        amountController.text,
      ); // tryParse('Hello') => null, tryParse('1.12') => 1.12

      final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
      if (amountIsInvalid) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('خطا'),
            content: const Text('ادخل رقم'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(
                  'حسنا',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        );
        return;
      }

      final id = uuid.v4().substring(0, 8);
      final user = User(
        id: id,
        name: studentName,
        isAdmin: isAdmin,
        number: amountController.text,
        isAccepted: isAccepted,
      );

      Prefs.setBool(kIsAdmin, isAdmin);
      Prefs.setBool(kIsSingInPressed, true);
      ref.read(usersNotifierNotifierProvider.notifier).addUser(user);
      // ref.read(usersNotifierNotifierProvider.notifier).setSingleUser(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WaitingAcceptView(id: id)),
      );
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropDownMenuList(
                  studentList: Students,
                  studentName: studentName,
                  onChange: (value) {
                    if (value == null) {
                      return;
                    }
                    studentName = value;

                    Prefs.setName(kUserName, value);
                    ref
                        .read(singInStudentNotifierProvider.notifier)
                        .changeStudent(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomToggleButton(
                  firstName: 'مستخدم',
                  secondName: "مسؤول",
                  onChanged: () {
                    isAdmin = !isAdmin;
                    log(isAdmin.toString());
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  labelName: 'رقم',
                  amountController: amountController,
                ),
                const SizedBox(height: 100),

                CustomButton(
                  buttonName: 'تسجيل الدخول',
                  onTap: () {
                    submitExpenseData(ref);
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
