import 'dart:developer';

import 'package:expenses/core/providers/users_notifier.dart';
import 'package:expenses/core/utils/shared_preferences_singleton.dart';
import 'package:expenses/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../../core/constants.dart';

class WaitingAcceptView extends ConsumerWidget {
  const WaitingAcceptView({super.key, required this.id});

  static const String routeName = 'WaitingAcceptView';
  final String id;

  Future<void> _handleRefresh(WidgetRef ref, BuildContext context) async {
    ref.read(usersNotifierNotifierProvider.notifier).setSingleUser(id);

    bool isUserAccepted =
        ref
            .watch(usersNotifierNotifierProvider.notifier)
            .singInUser
            ?.isAccepted ??
        false;

    if (isUserAccepted) {
      Prefs.setBool(kIsUserAccepted, true);
      Navigator.pushReplacementNamed(context, HomeView.routeName);
    }

    return await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: LiquidPullToRefresh(
          onRefresh: () => _handleRefresh(ref, context),
          height: 200,
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.contain,
                      width: 320,
                    ),
                    const SizedBox(height: 100),
                    const Column(
                      children: [
                        Text(
                          'لقد تم تسجيل الدخول بنجاح',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'يتبقى الموافقة من قبل المسؤولين',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'اسحب للاسفل لتحديث الصفحة',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
