import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/features/home/models/user.dart';
import 'package:expenses/core/providers/users_notifier.dart';
import 'package:expenses/features/setting/presentation/view/widget/show_user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowUser extends ConsumerWidget {
  const ShowUser({super.key});

  static const String routeName = 'ShowUser';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final users = ref.watch(userNotifierNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("عرض المستخدمين")),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: ref
              .read(usersNotifierNotifierProvider.notifier)
              .getUsersSnapshot(),
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
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'لا يوجد مستخدمين بعد',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              );
            }
            final users = snapshot.data!.docs
                .map((doc) => User.formFirebase(doc.data()))
                .toList();

            return ShowUserDetails(users: users);
          },
        ),
      ),
    );
  }
}
