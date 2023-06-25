import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/repository/course_repository.dart';
import '../../model/course/course.dart';
import '../../model/student/student.dart';
import 'widgets/card_buttom.dart';
import 'widgets/course_card.dart';

class ListCourse extends StatelessWidget {
  const ListCourse({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final courseRepository = Modular.get<CourseRepository>();
    return StreamBuilder<List<Course>>(
      stream: courseRepository.getListCourse(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: SelectableText(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Bem-vindo ao REVOLUÇÃO 3D',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const CardButtom(
                title: 'CARTEIRINHA',
                icon: Icon(
                  Icons.check,
                  size: 40,
                ),
              ),
              ListView.builder(
                itemCount: student.coursesInProgress.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final course = student.coursesInProgress[index];

                  return CourseCard(
                    title: course.name,
                    description: course.description,
                    image: course.imageUrl,
                    progress: course.progress?.toDouble() ?? 0.0,
                    onTap: () {
                      Modular.to.pushNamed(
                        '/course',
                        arguments: [course, student],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
