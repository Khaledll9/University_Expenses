import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelName,
    required this.amountController,
    this.prefixText = '',
  });

  final String labelName;
  final TextEditingController amountController;
  final String prefixText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixText: prefixText,
          hintText: 'ادخل رقم',
          hintStyle: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.secondary,
          ),
          labelText: labelName,
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

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a number';
          }
          return null;
        },
        onSaved: (value) {},
      ),
    );
  }
}
