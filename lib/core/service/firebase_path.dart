class FirebasePath {
  static FirebasePath? _instance;

  FirebasePath._();

  static FirebasePath get instance {
    _instance ??= FirebasePath._();
    return _instance!;
  }

  static const String coursesPath = 'courses';
  static const String sectionsPath = 'sections';
  static const String lessonsPath = 'lessons';
  static String sectionsListPath({
    required String courseId,
  }) =>
      '$coursesPath/$courseId/$sectionsPath/';
  static String courseLessonPath({
    required String courseId,
    required String sectionId,
  }) =>
      '$coursesPath/$courseId/$sectionsPath/$sectionId/$lessonsPath';
}
