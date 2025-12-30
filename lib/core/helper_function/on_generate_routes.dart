import 'package:expenses/features/add_expense/presentation/view/add_expense_view.dart';
import 'package:expenses/features/home/presentation/view/home_view.dart';
import 'package:expenses/features/home/presentation/view/my_payment_view.dart';
import 'package:expenses/features/setting/presentation/view/setting_view.dart';
import 'package:expenses/features/setting/presentation/view/show_student_view.dart';
import 'package:expenses/features/setting/presentation/view/widget/show_student_expense_view.dart';
import 'package:expenses/features/setting/presentation/view/widget/show_user.dart';
import 'package:expenses/features/sign_in/view/sign_in_view.dart';
import 'package:expenses/features/sign_in/view/widgets/waiting_accept_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting) {
  switch (setting.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case MyPaymentView.routeName:
      return MaterialPageRoute(
        builder: (context) => const MyPaymentView(expenses: []),
      );
    case SettingView.routeName:
      return MaterialPageRoute(
        builder: (context) => const SettingView(expenses: []),
      );
    case SignInView.routeName:
      return MaterialPageRoute(builder: (context) => const SignInView());
    case AddExpenseView.routeName:
      return MaterialPageRoute(builder: (context) => const AddExpenseView());
    case ShowStudentView.routeName:
      return MaterialPageRoute(builder: (context) => const ShowStudentView());
    case ShowUser.routeName:
      return MaterialPageRoute(builder: (context) => const ShowUser());
    case WaitingAcceptView.routeName:
      return MaterialPageRoute(
        builder: (context) => const WaitingAcceptView(id: ''),
      );
    case ShowStudentExpenseView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ShowStudentExpenseView(),
      );
    default:
      return MaterialPageRoute(builder: (context) => const Placeholder());
  }
}
