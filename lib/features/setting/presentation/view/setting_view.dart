import 'package:expenses/features/home/models/expense.dart';
import 'package:expenses/features/home/presentation/view/widget/money_card.dart';
import 'package:expenses/features/add_expense/presentation/view/add_expense_view.dart';
import 'package:expenses/features/setting/presentation/view/show_student_view.dart';
import 'package:expenses/features/setting/presentation/view/widget/custom_inkwell_button.dart';
import 'package:expenses/features/setting/presentation/view/widget/show_user.dart';
import 'package:expenses/features/setting/presentation/view/widget/toggle_dark_Light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants.dart';
import '../../../../core/utils/shared_preferences_singleton.dart';

class SettingView extends ConsumerWidget {
  const SettingView({required this.expenses, super.key});

  static const routeName = 'SettingView';
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int getSponsor(List<Expense> expenses) {
      int totalSponsor = 0;
      for (var expense in expenses) {
        if (!expense.isStudent && !expense.isExpense) {
          totalSponsor += int.parse(expense.amount);
        }
      }
      return totalSponsor;
    }

    int getStudent(List<Expense> expenses) {
      int totalStudent = 0;
      for (var expense in expenses) {
        if (expense.isStudent && !expense.isExpense) {
          totalStudent += int.parse(expense.amount);
        }
      }
      return totalStudent;
    }

    int totalSponsor = getSponsor(expenses);
    int totalStudent = getStudent(expenses);

    int getTotalMoney() {
      return totalStudent + totalSponsor;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          MoneyCard(
            incomeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedUserGroup03,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            expenseIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedCity02,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            expenseName: 'الداعمين',
            incomeName: 'الطلاب',
            balance: formatterNumber.format(getTotalMoney()),
            expense: formatterNumber.format(totalSponsor),
            income: formatterNumber.format(totalStudent),
            cardName: 'الاجمالي',
          ),
          const SizedBox(height: 30),

          const ToggleDarkLight(
            firstName: "الوضع العادي",
            secondName: 'الوضع الداكن',
          ),

          if (Prefs.getBool(kIsAdmin))
            Column(
              children: [
                const SizedBox(height: 30),
                CustomInkwellButton(
                  buttonName: 'إضافة او سحب',
                  onTap: () =>
                      Navigator.of(context).pushNamed(AddExpenseView.routeName),
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedMoneySafe,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 25),

                CustomInkwellButton(
                  buttonName: 'استعلام عن طالب',
                  onTap: () => Navigator.of(
                    context,
                  ).pushNamed(ShowStudentView.routeName),
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedUserSearch01,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 25),
                CustomInkwellButton(
                  buttonName: 'عرض المستخدمين',
                  onTap: () =>
                      Navigator.of(context).pushNamed(ShowUser.routeName),
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedUser03,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
