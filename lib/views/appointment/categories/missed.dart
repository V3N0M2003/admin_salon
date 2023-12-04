import 'package:flutter/material.dart';

class MissedApointments extends StatefulWidget {
  const MissedApointments({super.key});

  @override
  State<MissedApointments> createState() => _MissedApointmentsState();
}

class _MissedApointmentsState extends State<MissedApointments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Missed Appointments"),
      ),
    );
  }
}
