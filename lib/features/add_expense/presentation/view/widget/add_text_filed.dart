import 'package:flutter/material.dart';

class AddTextFiled extends StatelessWidget {
  const AddTextFiled({
    super.key,
    required this.textEditing,
    this.maxLines = 1,
    required this.title,
  });

  final TextEditingController textEditing;
  final int maxLines;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditing,
      maxLines: maxLines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        label: Text(title),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
