import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/repository/course_repository.dart';
import '../../core/widgets/loading_dialog.dart';
import '../../model/course/course.dart';
import '../../model/course/sections.dart';
import '../../model/student/student_course.dart';
import '../../model/student/student_lesson.dart';
import '../../model/student/student_sections.dart';

part 'course_controller.g.dart';

// ignore: library_private_types_in_public_api
class CourseController = _CourseControllerBase with _$CourseController;

abstract class _CourseControllerBase with Store {
  final CourseRepository _courseRepository;
  final LoadingDialog _loading;

  _CourseControllerBase(this._courseRepository, this._loading);

  @observable
  String? currentVideoUrl;

  @observable
  ObservableList<Sections>? setions = ObservableList.of([]);

  @observable
  ObservableList<StudentLesson>? studentLessons = ObservableList.of([]);

  @observable
  YoutubePlayerController? youtubeController;

  @observable
  int isLessonSelected = -1;

  @observable
  bool isFullScreen = false;

  @action
  void setLessonSelected(int value) => isLessonSelected = value;

  @action
  void initializeController(String videoId) {
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @action
  void changeVideo(String videoId) {
    youtubeController?.load(videoId);
  }

  @action
  void toggleFullScreenMode() {
    isFullScreen = !isFullScreen;
    youtubeController?.toggleFullScreenMode();
  }

  @action
  void addSetions(List<Sections>? newSetions) =>
      setions?.addAll([...newSetions!]);

  @action
  void addStudentLessons(List<StudentLesson>? newStudentLessons) =>
      studentLessons?.addAll([...newStudentLessons!]);

  StudentSections? getStudentSection(
    Sections section,
    List<StudentCourse>? studentCourses,
  ) {
    for (var studentCourse in studentCourses ?? <StudentCourse>[]) {
      if (studentCourse.sections != null) {
        final studentSection = studentCourse.sections!.firstWhere(
          (s) => s.id == section.id,
          orElse: () => StudentSections(),
        );
        return studentSection;
      }
    }

    return null;
  }

  bool areAllLessonsCompleted(
    Sections sections,
    List<StudentLesson>? studentLessons,
  ) {
    if (sections.lessons == null || studentLessons == null) {
      return false;
    }

    final lessonIds = sections.lessons!.map((lesson) => lesson.id).toSet();
    final completedLessonIds = studentLessons
        .where((studentLesson) => lessonIds.contains(studentLesson.id))
        .where((studentLesson) => studentLesson.isCompleted == true)
        .map((studentLesson) => studentLesson.id)
        .toSet();

    return lessonIds.difference(completedLessonIds).isEmpty;
  }

  @observable
  ObservableStream<List<Course>> courseStream() =>
      _courseRepository.getListCourse().asObservable();

  @observable
  ObservableStream<List<Sections>> setionsStream(String courseId) =>
      _courseRepository.getListSections(courseId).asObservable();

  bool isPreviousSectionCompleted(
    List<Sections> sections,
    int currentIndex,
    List<StudentLesson>? studentLessons,
    List<StudentCourse>? studentCourses,
  ) {
    if (currentIndex <= 0) {
      return true;
    }

    final previousSection = sections[currentIndex - 1];
    final previousSectionStudentSection =
        getStudentSection(previousSection, studentCourses);

    return areAllLessonsCompleted(
      previousSection,
      previousSectionStudentSection?.lessons,
    );
  }

  @action
  Future<void> nextPage(
    PageController pageController,
    List<StudentCourse>? studentCourses,
  ) async {
    if (setions != null) {
      final currentSection = setions![pageController.page!.round()];
      final studentSection = getStudentSection(currentSection, studentCourses);

      if (studentSection != null) {
        final bool isCurrentSectionCompleted = areAllLessonsCompleted(
          currentSection,
          studentSection.lessons,
        );

        if (isCurrentSectionCompleted) {
          final int totalPages = setions!.length;
          if (pageController.page! < totalPages - 1) {
            _loading.show();
            disposeYoutubeController();
            await Future.delayed(const Duration(milliseconds: 200));
            pageController.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
            setLessonSelected(-1);
            _loading.hide();
          }
        }
      }
    }
  }

  @action
  Future<void> previousPage(PageController pageController) async {
    disposeYoutubeController();
    await Future.delayed(const Duration(milliseconds: 200));
    pageController.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
    setLessonSelected(-1);
  }

  @action
  Future<void> disposeYoutubeController() async {
    youtubeController?.dispose();
    await Future.delayed(const Duration(milliseconds: 200));
    youtubeController = null;
  }
}
