import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../model/course/course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    this.onTap,
  });

  final Course course;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(
      Radius.circular(10),
    );

    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: course.imageUrl.isNotEmpty,
                      child: Container(
                        height: 80,
                        width: 80,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(course.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  course.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => Modular.to.pushNamed(
                                  '/course-details',
                                  arguments: course,
                                ),
                                icon: const Icon(Icons.info_outline),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            course.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    text: 'Progresso: ',
                    children: [
                      TextSpan(
                        text: '${(course.progress ?? 0.0) * 100}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: SizedBox(
                    height: 6,
                    child: LinearProgressIndicator(
                      value: course.progress?.toDouble() ?? 0.0,
                      semanticsLabel:
                          'Progresso: ${(course.progress?.toDouble() ?? 0.0) * 100}%',
                      semanticsValue:
                          '${(course.progress?.toDouble() ?? 0.0) * 100}%',
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
