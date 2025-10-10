import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({
    super.key,
    required this.firstName,
    required this.secondName,

    required this.onChanged,
  });
  final String firstName;
  final String secondName;
  final VoidCallback onChanged;

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool firstSwitchValue = true;
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
      current: firstSwitchValue,
      values: const [true, false],
      indicatorSize: const Size.fromWidth(125),
      customIconBuilder: (context, local, global) => Text(
        local.value ? widget.firstName : widget.secondName,
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
      onChanged: (value) {
        setState(() {
          firstSwitchValue = value;
        });

        widget.onChanged();
      },
    );
  }
}
