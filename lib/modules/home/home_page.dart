import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/repository/student_repository.dart';
import '../../model/course/sections.dart';
import '../../model/student/student.dart';
import '../../model/student/student_course.dart';
import '../../model/student/student_course_data.dart';
import '../../model/student/student_sections.dart';
import '../../model/user.dart';
import 'widgets/circular_perfil_icon.dart';
import 'widgets/course_card.dart';
import 'widgets/indicator.dart';
import 'widgets/poster_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController posterController;
  final ValueNotifier<int> _currentPoster = ValueNotifier(0);

  double calculateSectionProgress(
    Sections section,
    StudentSections studentSection,
  ) {
    if (section.lessons == null || studentSection.lessons == null) {
      return 0.0;
    }

    final totalLessons = section.lessons!.length;
    final completedLessons = studentSection.lessons!
        .where((studentLesson) => studentLesson.isCompleted == true)
        .length;

    return completedLessons / totalLessons;
  }

  @override
  void initState() {
    super.initState();
    posterController = PageController(
      viewportFraction: 0.9,
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentRepository = Modular.get<StudentRepository>();

    return StreamBuilder<Student>(
      stream: studentRepository.getStudents(widget.user.id),
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
          return const Material(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        final student = snapshot.data;
        return student != null
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  leading: CircularPerfilIcon(
                    student: student,
                    onTap: () {
                      Modular.to.pushNamed(
                        '/profile',
                        arguments: student,
                      );
                    },
                  ),
                  titleSpacing: 10,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
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
                body: SingleChildScrollView(
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
                      const SizedBox(height: 10),
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: PageView.builder(
                          controller: posterController,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return const Poster(
                              url:
                                  'https://th.bing.com/th/id/OIP.R-UH5h6qiTOnkjjPmla3xAHaE8?pid=ImgDet&rs=1',
                            );
                          },
                          onPageChanged: (value) {
                            _currentPoster.value = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            4,
                            (index) => AnimatedBuilder(
                              animation: _currentPoster,
                              builder: (context, _) {
                                return Indicator(
                                  isActive: _currentPoster.value == index
                                      ? true
                                      : false,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      /*const CardButtom(
                        title: 'CARTEIRINHA',
                        icon: Icon(
                          Icons.check,
                          size: 40,
                        ),
                      ),*/
                      Text(
                        'Meus Cursos',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        itemCount: student.coursesInProgress.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final course = student.coursesInProgress[index];

                          return StreamBuilder<List<StudentCourse>>(
                            stream: studentRepository.studentListCourses(
                              student.id,
                              course.id,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    snapshot.error.toString(),
                                  ),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }

                              return CourseCard(
                                course: course,
                                onTap: () {
                                  Modular.to.pushNamed(
                                    '/course',
                                    arguments: StudentCourseData(
                                      course: course,
                                      student: student,
                                      studentCourses: snapshot.data,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Material(
                child: Center(child: Text('Empty data $student')),
              );
      },
    );
  }
}
