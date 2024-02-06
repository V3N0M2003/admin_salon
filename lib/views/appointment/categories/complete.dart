import 'package:flutter/material.dart';

class CompleteApointment extends StatefulWidget {
  const CompleteApointment({super.key});

  @override
  State<CompleteApointment> createState() => _CompleteApointmentState();
}

class _CompleteApointmentState extends State<CompleteApointment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("Completed Appointments"),
      ),
    );
  }
}
