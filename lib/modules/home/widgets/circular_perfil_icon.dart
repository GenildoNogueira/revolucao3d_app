import 'package:flutter/material.dart';

import '../../../model/student/student.dart';

class CircularPerfilIcon extends StatelessWidget {
  const CircularPerfilIcon({
    super.key,
    required this.student,
    this.onTap,
  });

  final Student student;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        student.imageUrl != null && (student.imageUrl ?? '').isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: CircleAvatar(
        maxRadius: 60,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundImage: imageUrl ? NetworkImage(student.imageUrl!) : null,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: !imageUrl
                ? SizedBox.expand(
                    child: Center(
                      child: Text(
                        student.fullName.characters.first,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
