import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onTap,
  });

  final String buttonName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withAlpha(200),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        height: 50,
        width: double.infinity,
        child: Text(
          buttonName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
