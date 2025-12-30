import 'package:expenses/core/widgets/drop_down_menu_list.dart';
import 'package:expenses/features/add_expense/presentation/view/widget/add_text_filed.dart'; // Naming convention: keeping original file name
import 'package:expenses/features/add_expense/view_model/add_expense_view_model.dart';
import 'package:expenses/features/home/models/expense.dart'; // For formatter
import 'package:expenses/features/home/models/user.dart';
import 'package:expenses/features/sign_in/view/widgets/custom_text_field.dart';
import 'package:expenses/features/sign_in/view/widgets/custom_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class AddExpenseView extends ConsumerStatefulWidget {
  const AddExpenseView({super.key});

  static const routeName = 'AddExpenseView';

  @override
  ConsumerState<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends ConsumerState<AddExpenseView> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: ref.read(addExpenseViewModelProvider).selectedDate,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      ref.read(addExpenseViewModelProvider.notifier).updateDate(pickedDate);
    }
  }

  void _submitData() {
    final success = ref
        .read(addExpenseViewModelProvider.notifier)
        .submitExpense(
          titleInput: _titleController.text,
          amountInput: _amountController.text,
          noteInput: _noteController.text,
        );

    if (!success) {
      _showErrorDialog();
    } else {
      Navigator.pop(context);
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('خطا'), // Consider localizing
        content: const Text('ادخل المبلغ'),
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
    final state = ref.watch(addExpenseViewModelProvider);
    final viewModel = ref.read(addExpenseViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('إضافة او سحب')),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CustomToggleButton(
                    firstName: "طالب",
                    secondName: "داعم",
                    currentValue: state.isStudent,
                    onChanged: viewModel.toggleUserType,
                  ),
                  if (state.isStudent)
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        DropDownMenuList(
                          studentList: Students,
                          studentName: state.studentName,
                          onChange: viewModel.updateStudentName,
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  if (!state.isStudent)
                    Column(
                      children: [
                        const SizedBox(height: 25),
                        AddTextFiled(
                          textEditing: _titleController,
                          title: 'اسم الداعم',
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          amountController: _amountController,
                          labelName: 'المبلغ',
                          prefixText: 'YER ',
                        ),
                      ),

                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(formatter.format(state.selectedDate)),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: HugeIcon(
                                icon: HugeIcons.strokeRoundedCalendar03,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: TextButton(
                          onPressed: _submitData,
                          child: Text(
                            'حفظ',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'إلغاء',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  CustomToggleButton(
                    firstName: 'إضافة',
                    secondName: 'سحب',
                    currentValue: !state.isExpense,
                    onChanged: viewModel.toggleExpenseType,
                  ),
                  const SizedBox(height: 50),
                  AddTextFiled(
                    textEditing: _noteController,
                    title: 'ملاحظة',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
