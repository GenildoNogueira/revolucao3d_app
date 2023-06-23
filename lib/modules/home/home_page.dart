import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/repository/student_repository.dart';
import '../../model/student/student.dart';
import '../../model/user.dart';
import 'list_course.dart';
import 'widgets/circular_perfil_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final studentRepository = Modular.get<StudentRepository>();
    return StreamBuilder<Student>(
      stream: studentRepository.getStudents(user.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log('Error: ', error: snapshot.error);
          return Material(
            child: Center(
              child: SelectableText(snapshot.error.toString()),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        final student = snapshot.data;
        return student != null
            ? Scaffold(
                appBar: AppBar(
                  leading: CircularPerfilIcon(
                    student: student,
                    onTap: () {
                      Modular.to.pushNamed(
                        '/profile',
                        arguments: student,
                      );
                    },
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        student.identificationNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                body: ListCourse(
                  student: student,
                ),
              )
            : Material(
                child: Center(child: Text('Empty data $student')),
              );
      },
    );
  }
}
