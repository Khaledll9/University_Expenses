import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/core/models/expense.dart';
import 'package:expenses/core/providers/expense_notifier.dart';
import 'package:expenses/core/widgets/drop_down_menu_list.dart';
import 'package:expenses/features/add_expense/presentation/view/widget/add_text_filed.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/custom_text_field.dart';
import 'package:expenses/features/sing_in/presentation/view/widget/custom_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/models/user.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  static const routeName = 'AddExpenseView';

  @override
  State<AddExpenseView> createState() {
    return _AddExpenseViewState();
  }
}

class _AddExpenseViewState extends State<AddExpenseView> {
  CollectionReference collRef = FirebaseFirestore.instance.collection(
    'expenses',
  );

  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  final _amountController = TextEditingController();
  bool isExpense = false;
  DateTime _selectedDate = DateTime.now();
  String studentName = Students.first;
  bool isStudent = true;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate == null) {
      return;
    }
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData(WidgetRef ref) {
    final enteredAmount = int.tryParse(
      _amountController.text,
    ); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final title = _titleController.text.trim().isEmpty
        ? studentName
        : _titleController.text;
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (amountIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('خطا'),
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
      return;
    }
    final expense = Expense(
      isStudent: isStudent,
      isExpense: isExpense,
      title: title,
      id: uuid.v4().substring(0, 8),
      note: _noteController.text,
      amount: _amountController.text,
      date: _selectedDate.toString().substring(0, 10),
    );
    ref.read(expenseNotifierProvider.notifier).addExpense(expense);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    onChanged: () {
                      setState(() {
                        isStudent = !isStudent;
                      });
                    },
                  ),
                  if (isStudent)
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        DropDownMenuList(
                          studentList: Students,
                          studentName: studentName,
                          onChange: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              studentName = value;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  if (!isStudent)
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
                            Text(formatter.format(_selectedDate)),
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
                        child: Consumer(
                          builder: (context, ref, child) {
                            return TextButton(
                              onPressed: () {
                                _submitExpenseData(ref);
                              },
                              child: Text(
                                'حفظ',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.inversePrimary,
                                ),
                              ),
                            );
                          },
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
                    onChanged: () {
                      isExpense = !isExpense;
                    },
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
