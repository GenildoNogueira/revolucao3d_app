import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/course/lesson.dart';
import '../../../model/student/student_lesson.dart';

class LessonWidget extends StatelessWidget {
  const LessonWidget({
    super.key,
    required this.lesson,
    required this.isLessonSelected,
    this.studentLesson,
    this.onTap,
  });

  final Lesson lesson;
  final bool isLessonSelected;
  final StudentLesson? studentLesson;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: ListTile(
        tileColor: const Color(0xFFD0E3E9),
        selectedTileColor: const Color(0xFFD0E3E9),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        title: Text(lesson.name),
        selected: isLessonSelected,
        leading: !isLessonSelected
            ? SizedBox(
                width: 32,
                height: 32,
                child: studentLesson?.isCompleted ?? false
                    ? const Icon(
                        Icons.check_circle_outline_outlined,
                        color: Colors.black,
                        size: 30,
                      )
                    : SvgPicture.asset('assets/icons/ic_play_outline.svg'),
              )
            : null,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Conteúdo: ${lesson.description}'),
            Text('Duração: ${lesson.duration} minutos'),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: SizedBox(
                height: 6,
                child: LinearProgressIndicator(
                  value: studentLesson?.currentPosition?.toDouble() ?? 0.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        trailing: isLessonSelected
            ? SizedBox(
                width: 28,
                height: 28,
                child: SvgPicture.asset('assets/icons/frame.svg'),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
