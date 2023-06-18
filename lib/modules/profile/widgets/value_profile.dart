import 'package:flutter/material.dart';

class ValueProfile extends StatelessWidget {
  const ValueProfile({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            letterSpacing: 0,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
            ),
            const Icon(
              Icons.lock,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Divider(
          thickness: 2,
          color: Color.fromRGBO(225, 227, 232, 1),
        ),
      ],
    );
  }
}
