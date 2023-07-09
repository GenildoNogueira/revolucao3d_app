import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isActive ? 20.0 : 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          color: isActive ? theme.primary : Colors.grey,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
