import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class CompletedAppointmentsGraph extends StatefulWidget {
  @override
  _CompletedAppointmentsGraphState createState() =>
      _CompletedAppointmentsGraphState();
}

class _CompletedAppointmentsGraphState
    extends State<CompletedAppointmentsGraph> {
  List<int> completedAppointmentsByMonth = List.filled(13, 0);

  @override
  void initState() {
    super.initState();
    fetchCompletedAppointments();
  }

  Future<void> fetchCompletedAppointments() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('complete', isEqualTo: "1")
        .get();

    snapshot.docs.forEach((doc) {
      final dateString = doc['bookingDate'].substring(5, 7);

      final month = int.parse(dateString);

      setState(() {
        completedAppointmentsByMonth[month]++;
      });
    });

    print('Completed Appointments by Month: $completedAppointmentsByMonth');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 1.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Appointments by Month',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 1.5,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  maxY: completedAppointmentsByMonth
                      .reduce(
                          (value, element) => value > element ? value : element)
                      .toDouble(),
                  barGroups: [
                    for (int i = 1; i <= 12; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            y: completedAppointmentsByMonth[i].toDouble(),
                            colors: [Colors.green],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
