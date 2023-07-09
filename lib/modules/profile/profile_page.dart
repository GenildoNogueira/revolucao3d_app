import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/extencions/extencions.dart';
import '../../model/student/student.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/value_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.student,
  });

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
          ),
        ),
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileAvatar(student: student),
            const SizedBox(height: 20),
            Text(
              student.fullName,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 2,
              color: Color.fromRGBO(225, 227, 232, 1),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Seus cursos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: student.coursesInProgress.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Text(
                  student.coursesInProgress[index].name,
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 0,
                    height: 1.20,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
            const Divider(
              thickness: 2,
              color: Color.fromRGBO(225, 227, 232, 1),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ValueProfile(
                    label: 'Nº de Identificação',
                    value: student.identificationNumber,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ValueProfile(
                    label: 'Data da Matricula',
                    value: student.enrollmentDate.dateFormatBR,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ValueProfile(
                    label: 'Data de Nascimento',
                    value: student.personalData.dateOfBirth.dateFormatBR,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ValueProfile(
                    label: 'Sexo',
                    value: student.personalData.gender,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ValueProfile(
              label: 'Email',
              value: student.contact.email,
            ),
            const SizedBox(height: 10),
            ValueProfile(
              label: 'Endereço',
              value: student.contact.address,
            ),
            const SizedBox(height: 10),
            ValueProfile(
              label: 'Nacionalidade',
              value: student.personalData.nationality,
            ),
            const SizedBox(height: 10),
            ValueProfile(
              label: 'Telefone',
              value: student.contact.phoneNumber,
            ),
          ],
        ),
      ),
    );
  }
}
