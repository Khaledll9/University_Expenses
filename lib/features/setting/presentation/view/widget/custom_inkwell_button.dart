import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomInkwellButton extends StatelessWidget {
  const CustomInkwellButton({
    super.key,
    required this.buttonName,
    required this.onTap,
    required this.icon,
  });
  final String buttonName;
  final Function() onTap;
  final HugeIcon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withAlpha(200),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.only(right: 12),
        width: double.infinity,
        height: 60,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              buttonName,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
