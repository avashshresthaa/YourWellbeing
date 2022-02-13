import 'package:flutter/material.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import '../Login/loginpermission.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: MainAppBar('Appointment'),
      body: const AppointmentContent(),
    );
  }
}

class AppointmentContent extends StatefulWidget {
  const AppointmentContent({Key? key}) : super(key: key);

  @override
  _AppointmentContentState createState() => _AppointmentContentState();
}

class _AppointmentContentState extends State<AppointmentContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SignUpContent(),
      ],
    );
  }
}
