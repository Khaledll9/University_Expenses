import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expenses/core/models/expense.dart';
import 'package:expenses/core/providers/expense_notifier.dart';
import 'package:expenses/core/providers/navigator_bar_notifier.dart';
import 'package:expenses/features/home/presentation/view/widget/total_balance_view.dart';
import 'package:expenses/features/my_payment/presentation/view/my_payment_view.dart';
import 'package:expenses/features/setting/presentation/view/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final _fireStore = FirebaseFirestore.instance.collection('expenses');

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  static const routeName = "HomeView";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(navigatorBarNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: StreamBuilder<List<Expense>>(
            stream: ref
                .read(expenseNotifierProvider.notifier)
                .getExpenseSnapshot(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'هناك مشكلة في تلقي البيانات',
                    style: TextStyle(fontSize: 24),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                );
              }

              final expenses = snapshot.data!;
              return [
                MyPaymentView(expenses: expenses),
                TotalBalanceView(expenses: expenses),
                SettingView(expenses: expenses),
              ][selectedIndex];
            },
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Theme.of(context).colorScheme.onSecondary,
          items: items,
          height: 60,

          index: selectedIndex,
          onTap: (index) {
            ref
                .read(navigatorBarNotifierProvider.notifier)
                .setNavigationBar(index);
          },
        ),
      ),
    );
  }
}
