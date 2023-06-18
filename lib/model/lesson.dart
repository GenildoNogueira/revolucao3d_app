class Lesson {
  final String name;
  final String description;
  final String duration;
  final bool isCompleted;
  double currentPosition;

  Lesson({
    required this.name,
    required this.description,
    required this.duration,
    required this.isCompleted,
    this.currentPosition = 0.0,
  });
}

List<Lesson> lessons = [
  Lesson(
    name: 'Aula 1',
    description: 'Descrição da aula 1',
    duration: '19',
    isCompleted: true,
  ),
  Lesson(
    name: 'Aula 2',
    description: 'Descrição da aula 2',
    duration: '30',
    isCompleted: true,
  ),
  Lesson(
    name: 'Aula 3',
    description: 'Descrição da aula 3',
    duration: '22',
    isCompleted: false,
  ),
  Lesson(
    name: 'Aula 4',
    description: 'Descrição da aula 4',
    duration: '25',
    isCompleted: false,
  ),
];
