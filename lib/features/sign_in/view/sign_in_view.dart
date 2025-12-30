import 'package:expenses/core/widgets/drop_down_menu_list.dart';
import 'package:expenses/features/home/models/user.dart';
import 'package:expenses/features/sign_in/view/widgets/custom_button.dart';
import 'package:expenses/features/sign_in/view/widgets/custom_text_field.dart';
import 'package:expenses/features/sign_in/view/widgets/custom_toggle_button.dart';
import 'package:expenses/features/sign_in/view/widgets/waiting_accept_view.dart';
import 'package:expenses/features/sign_in/view_model/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  static const String routeName = 'SignInView';

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _submitData() async {
    final viewModel = ref.read(signInViewModelProvider.notifier);
    final id = await viewModel.signIn(amountController.text);

    if (id != null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WaitingAcceptView(id: id)),
        );
      }
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
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
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signInViewModelProvider);
    final viewModel = ref.read(signInViewModelProvider.notifier);

    // User is true (firstName), Admin is false (secondName) logic from original app?
    // Original: firstName: 'مستخدم', secondName: "مسؤول"
    // Toggle: true -> User, false -> Admin?
    // state.isAdmin = false (default) implies User.
    // So if isAdmin is false, we want Toggle to be true.
    final toggleValue = !state.isAdmin;

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
                  studentName: state.studentName,
                  onChange: (value) {
                    if (value != null) {
                      viewModel.changeStudent(value);
                    }
                  },
                ),
                const SizedBox(height: 25),
                CustomToggleButton(
                  firstName: 'مستخدم',
                  secondName: "مسؤول",
                  currentValue: toggleValue,
                  onChanged: viewModel.toggleAdmin,
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  labelName: 'رقم',
                  amountController: amountController,
                ),
                const SizedBox(height: 100),

                CustomButton(buttonName: 'تسجيل الدخول', onTap: _submitData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
