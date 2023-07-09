// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CourseController on _CourseControllerBase, Store {
  late final _$currentVideoUrlAtom =
      Atom(name: '_CourseControllerBase.currentVideoUrl', context: context);

  @override
  String? get currentVideoUrl {
    _$currentVideoUrlAtom.reportRead();
    return super.currentVideoUrl;
  }

  @override
  set currentVideoUrl(String? value) {
    _$currentVideoUrlAtom.reportWrite(value, super.currentVideoUrl, () {
      super.currentVideoUrl = value;
    });
  }

  late final _$setionsAtom =
      Atom(name: '_CourseControllerBase.setions', context: context);

  @override
  ObservableList<Sections>? get setions {
    _$setionsAtom.reportRead();
    return super.setions;
  }

  @override
  set setions(ObservableList<Sections>? value) {
    _$setionsAtom.reportWrite(value, super.setions, () {
      super.setions = value;
    });
  }

  late final _$studentLessonsAtom =
      Atom(name: '_CourseControllerBase.studentLessons', context: context);

  @override
  ObservableList<StudentLesson>? get studentLessons {
    _$studentLessonsAtom.reportRead();
    return super.studentLessons;
  }

  @override
  set studentLessons(ObservableList<StudentLesson>? value) {
    _$studentLessonsAtom.reportWrite(value, super.studentLessons, () {
      super.studentLessons = value;
    });
  }

  late final _$youtubeControllerAtom =
      Atom(name: '_CourseControllerBase.youtubeController', context: context);

  @override
  YoutubePlayerController? get youtubeController {
    _$youtubeControllerAtom.reportRead();
    return super.youtubeController;
  }

  @override
  set youtubeController(YoutubePlayerController? value) {
    _$youtubeControllerAtom.reportWrite(value, super.youtubeController, () {
      super.youtubeController = value;
    });
  }

  late final _$isLessonSelectedAtom =
      Atom(name: '_CourseControllerBase.isLessonSelected', context: context);

  @override
  int get isLessonSelected {
    _$isLessonSelectedAtom.reportRead();
    return super.isLessonSelected;
  }

  @override
  set isLessonSelected(int value) {
    _$isLessonSelectedAtom.reportWrite(value, super.isLessonSelected, () {
      super.isLessonSelected = value;
    });
  }

  late final _$isFullScreenAtom =
      Atom(name: '_CourseControllerBase.isFullScreen', context: context);

  @override
  bool get isFullScreen {
    _$isFullScreenAtom.reportRead();
    return super.isFullScreen;
  }

  @override
  set isFullScreen(bool value) {
    _$isFullScreenAtom.reportWrite(value, super.isFullScreen, () {
      super.isFullScreen = value;
    });
  }

  @override
  ObservableStream<List<Course>> courseStream() {
    final _$stream = super.courseStream();
    return ObservableStream<List<Course>>(_$stream, context: context);
  }

  @override
  ObservableStream<List<Sections>> setionsStream(String courseId) {
    final _$stream = super.setionsStream(courseId);
    return ObservableStream<List<Sections>>(_$stream, context: context);
  }

  late final _$nextPageAsyncAction =
      AsyncAction('_CourseControllerBase.nextPage', context: context);

  @override
  Future<void> nextPage(
      PageController pageController, List<StudentCourse>? studentCourses) {
    return _$nextPageAsyncAction
        .run(() => super.nextPage(pageController, studentCourses));
  }

  late final _$previousPageAsyncAction =
      AsyncAction('_CourseControllerBase.previousPage', context: context);

  @override
  Future<void> previousPage(PageController pageController) {
    return _$previousPageAsyncAction
        .run(() => super.previousPage(pageController));
  }

  late final _$disposeYoutubeControllerAsyncAction = AsyncAction(
      '_CourseControllerBase.disposeYoutubeController',
      context: context);

  @override
  Future<void> disposeYoutubeController() {
    return _$disposeYoutubeControllerAsyncAction
        .run(() => super.disposeYoutubeController());
  }

  late final _$_CourseControllerBaseActionController =
      ActionController(name: '_CourseControllerBase', context: context);

  @override
  void setLessonSelected(int value) {
    final _$actionInfo = _$_CourseControllerBaseActionController.startAction(
        name: '_CourseControllerBase.setLessonSelected');
    try {
      return super.setLessonSelected(value);
    } finally {
      _$_CourseControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initializeController(String videoId) {
    final _$actionInfo = _$_CourseControllerBaseActionController.startAction(
        name: '_CourseControllerBase.initializeController');
    try {
      return super.initializeController(videoId);
    } finally {
      _$_CourseControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeVideo(String videoId) {
    final _$actionInfo = _$_CourseControllerBaseActionController.startAction(
        name: '_CourseControllerBase.changeVideo');
    try {
      return super.changeVideo(videoId);
    } finally {
      _$_CourseControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFullScreenMode() {
    final _$actionInfo = _$_CourseControllerBaseActionController.startAction(
        name: '_CourseControllerBase.toggleFullScreenMode');
    try {
      return super.toggleFullScreenMode();
    } finally {
      _$_CourseControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSetions(List<Sections>? newSetions) {
    final _$actionInfo = _$_CourseControllerBaseActionController.startAction(
        name: '_CourseControllerBase.addSetions');
    try {
      return super.addSetions(newSetions);
    } finally {
      _$_CourseControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addStudentLessons(List<StudentLesson>? newStudentLessons) {
    final _$actionInfo = _$_CourseControllerBaseActionController.startAction(
        name: '_CourseControllerBase.addStudentLessons');
    try {
      return super.addStudentLessons(newStudentLessons);
    } finally {
      _$_CourseControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentVideoUrl: ${currentVideoUrl},
setions: ${setions},
studentLessons: ${studentLessons},
youtubeController: ${youtubeController},
isLessonSelected: ${isLessonSelected},
isFullScreen: ${isFullScreen}
    ''';
  }
}
