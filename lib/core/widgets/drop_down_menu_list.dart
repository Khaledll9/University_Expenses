import 'package:flutter/material.dart';

class DropDownMenuList extends StatelessWidget {
  const DropDownMenuList({
    required this.studentName,
    super.key,
    required this.onChange,
    required this.studentList,
  });

  final ValueChanged<String?>? onChange;
  final String studentName;
  final List<String> studentList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: const [
          BoxShadow(blurRadius: 15, spreadRadius: -16, offset: Offset(12, 6)),
          BoxShadow(blurRadius: 15, spreadRadius: -16, offset: Offset(-11, 6)),
        ],
      ),
      child: DropdownButton(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        underline: Container(height: 0),
        dropdownColor: Theme.of(context).colorScheme.onPrimary,
        value: studentName,
        items: studentList
            .map(
              (student) =>
                  DropdownMenuItem(value: student, child: Text(student)),
            )
            .toList(),
        onChanged: onChange,
      ),
    );
  }
}
