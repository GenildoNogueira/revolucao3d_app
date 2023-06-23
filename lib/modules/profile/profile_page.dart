import 'package:flutter/material.dart';

import '../../model/student/student.dart';
import 'widgets/card_profile.dart';
import 'widgets/value_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.student,
  });

  final Student student;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(
      Radius.circular(20),
    );

    String dateOfBirth(DateTime dateTime) {
      final String day = dateTime.day.toString();
      final String month = dateTime.month.toString();
      final String year = dateTime.year.toString();
      return [
        day,
        month,
        year,
      ].join('/');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {},
              borderRadius: borderRadius,
              child: Container(
                width: 86,
                height: 28,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius,
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      size: 20,
                      color: Color.fromARGB(255, 97, 132, 199),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'FEITO',
                      style: TextStyle(
                        height: 1.28,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 97, 132, 199),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CardProfile(
              student: student,
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
                    value: dateOfBirth(student.enrollmentDate),
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
                    value: dateOfBirth(student.personalData.dateOfBirth),
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
