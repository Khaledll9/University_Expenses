import 'package:expenses/core/models/user.dart';
import 'package:expenses/core/providers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

class ShowUserDetails extends ConsumerWidget {
  const ShowUserDetails({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.horizontal,
            background: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade500,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: HugeIcon(
                icon: HugeIconsStrokeRounded.checkmarkSquare04,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),

            secondaryBackground: Container(
              decoration: BoxDecoration(
                color: Colors.red.shade500,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
              child: HugeIcon(
                icon: HugeIconsStrokeRounded.strokeRoundedDelete03,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            key: ValueKey(users[index].id),

            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                ref
                    .read(userNotifierNotifierProvider.notifier)
                    .updateUser(users[index]);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    clipBehavior: Clip.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    duration: const Duration(seconds: 3),
                    content: Text(
                      'لقد تم قبول الطالب بنجاح',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                );
                return false;
              } else if (direction == DismissDirection.endToStart) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    clipBehavior: Clip.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    duration: const Duration(seconds: 3),
                    content: Text(
                      'لقد تم حذف الطالب بنجاح',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                );
                ref
                    .read(userNotifierNotifierProvider.notifier)
                    .deleteUser(users[index].id);
                return true;
              }
              // For any other direction, prevent dismissal by default
              return false;
            },
            child: Card(
              color: Theme.of(context).colorScheme.inversePrimary,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                trailing: Text(
                  users[index].isAccepted ? 'مقبول' : "قيد الانتظار",
                ),
                leading: Text(users[index].isAdmin ? 'مسؤول' : "مستخدم"),
                subtitle: Text(users[index].number),
                title: Text(users[index].name),
              ),
            ),
          );
        },
      ),
    );
  }
}
