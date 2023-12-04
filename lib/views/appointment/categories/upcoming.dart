import 'package:flutter/material.dart';

class UpcomingApointments extends StatefulWidget {
  const UpcomingApointments({super.key});

  @override
  State<UpcomingApointments> createState() => _UpcomingApointmentsState();
}

class _UpcomingApointmentsState extends State<UpcomingApointments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Upcoming Appointments"),
      ),
    );
  }
}
