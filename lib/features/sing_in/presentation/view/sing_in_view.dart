import 'package:expenses/core/models/expense.dart';
import 'package:expenses/core/models/user.dart';
import 'package:expenses/core/providers/sing_in_student_notifier.dart';
import 'package:expenses/core/providers/user_notifier.dart';
import 'package:expenses/core/widgets/drop_down_menu_list.dart';
import 'package:expenses/features/home/presentation/view/home_view.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/custom_buttom.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/custom_text_field.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/custom_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      ref.read(userNotifierNotifierProvider.notifier).addUser(user);
      ref.read(userNotifierNotifierProvider.notifier).getSingleUser(id);
      Navigator.pushNamed(context, HomeView.routeName);

      // Navigator.of(
      //   context,
      // ).push(MaterialPageRoute(builder: (context) => WaitingAcceptView()));
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
