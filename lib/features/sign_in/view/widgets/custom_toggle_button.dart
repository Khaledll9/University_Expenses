import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class CustomToggleButton extends StatelessWidget {
  const CustomToggleButton({
    super.key,
    required this.firstName,
    required this.secondName,
    required this.onChanged,
    required this.currentValue,
  });

  final String firstName;
  final String secondName;
  final VoidCallback onChanged;
  final bool currentValue;

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch.size(
      styleList: [
        ToggleStyle(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        ToggleStyle(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ],
      current: currentValue,
      values: const [true, false],
      indicatorSize: const Size.fromWidth(125),
      customIconBuilder: (context, local, global) => Text(
        local.value ? firstName : secondName,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Color.lerp(
            Theme.of(context).colorScheme.onSurface,
            Theme.of(context).colorScheme.inversePrimary,
            local.animationValue,
          ),
        ),
      ),
      borderWidth: 3.0,
      iconAnimationType: AnimationType.onHover,
      style: ToggleStyle(
        indicatorColor: Theme.of(context).colorScheme.secondary.withAlpha(200),
        borderColor: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          const BoxShadow(
            blurRadius: 8,
            spreadRadius: -15,
            offset: Offset(0, 12),
          ),
        ],
      ),
      selectedIconScale: 1,
      // The original widget called onChanged() which was VoidCallback,
      // but AnimatedToggleSwitch passes the new value.
      // We should probably rely on the parent to update the state passed in 'currentValue'.
      onChanged: (value) {
        onChanged();
      },
    );
  }
}
