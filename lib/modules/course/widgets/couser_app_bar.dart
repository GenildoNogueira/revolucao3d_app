import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

import '../course_controller.dart';

class CourseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CourseAppBar({
    super.key,
    required this.title,
    required this.closePage,
    required this.controller,
    this.appBarHeight = 60,
  });
  final String title;
  final VoidCallback closePage;
  final CourseController controller;
  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => !controller.isFullScreen
          ? SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: closePage,
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 35,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        controller.isFullScreen ? 0.0 : appBarHeight,
      );
}
