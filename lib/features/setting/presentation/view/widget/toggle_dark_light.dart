import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:expenses/core/providers/change_theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleDarkLight extends ConsumerWidget {
  const ToggleDarkLight({
    super.key,
    required this.firstName,
    required this.secondName,
  });
  final String firstName;
  final String secondName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool firstSwitchValue = ref
        .watch(changeThemeNotifierProvider.notifier)
        .isLight;
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
      onChanged: (value) {
        firstSwitchValue = value;
        ref.read(changeThemeNotifierProvider.notifier).toggleTheme();
      },
    );
  }
}
