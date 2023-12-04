import 'package:flutter/material.dart';

class TodayAppointment extends StatefulWidget {
  const TodayAppointment({super.key});

  @override
  State<TodayAppointment> createState() => _TodayAppointmentState();
}

class _TodayAppointmentState extends State<TodayAppointment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Today's Appointments"),
      ),
    );
  }
}
