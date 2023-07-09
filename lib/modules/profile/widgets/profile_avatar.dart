import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/student/student.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: const BorderRadius.all(
        Radius.circular(100),
      ),
      child: Ink(
        child: Container(
          width: 200,
          height: 200,
          clipBehavior: Clip.none,
          decoration: const BoxDecoration(
            color: Color(0xFFD0E3E9),
            shape: BoxShape.circle,
          ),
          child: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/ic_camera.svg',
              width: 25,
              height: 25,
            ),
          ),
        ),
      ),
    );
  }
}
