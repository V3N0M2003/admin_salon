import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  Map<String, int> completedAppointmentsByWeek = {};
  List<String> allDaysOfWeek = [];
  int missingAppointmentsCount = 1;
  int completedAppointmentsCount = 1;
  int upcomingAppointmentsCount = 1;
  int allmissingAppointmentsCount = 1;
  int allcompletedAppointmentsCount = 1;
  int allupcomingAppointmentsCount = 1;
  bool showWeeklyChart = true;

  @override
  void initState() {
    super.initState();
    initializeDaysOfWeek();
    fetchCompletedAppointments();
    fetchAllApointments();
  }

  void initializeDaysOfWeek() {
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));

    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      allDaysOfWeek.add(DateFormat('yyyy-MM-dd').format(day));
    }
  }

  Future<void> fetchCompletedAppointments() async {
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    final endOfWeek =
        startOfWeek.add(Duration(days: 7)).subtract(Duration(seconds: 1));

    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('bookingDate',
            isGreaterThanOrEqualTo: startOfWeek.toIso8601String())
        .where('bookingDate', isLessThanOrEqualTo: endOfWeek.toIso8601String())
        .get();

    snapshot.docs.forEach((doc) {
      final complete = doc['complete'];
      final bookingDate = DateTime.parse(doc['bookingDate']);

      if (complete == "1") {
        final week = '${DateFormat('yyyy-MM-dd').format(bookingDate)}';
        setState(() {
          completedAppointmentsCount++;
          if (completedAppointmentsByWeek.containsKey(week)) {
            completedAppointmentsByWeek[week] =
                (completedAppointmentsByWeek[week] ?? 0) + 1;
          } else {
            completedAppointmentsByWeek[week] = 1;
          }
        });
      } else {
        final now = DateTime.now();
        if (bookingDate.isBefore(DateTime(now.year, now.month, now.day))) {
          setState(() {
            missingAppointmentsCount++;
          });
        } else {
          setState(() {
            upcomingAppointmentsCount++;
          });
        }
      }
    });

    print('Completed Appointments by Week: $completedAppointmentsByWeek');
  }

  Future<void> fetchAllApointments() async {
    final now = DateTime.now();

    final snapshot =
        await FirebaseFirestore.instance.collection('bookings').get();

    snapshot.docs.forEach((doc) {
      final complete = doc['complete'];
      final bookingDate = DateTime.parse(doc['bookingDate']);

      if (complete == "1") {
        setState(() {
          allcompletedAppointmentsCount++;
        });
      } else {
        if (bookingDate.isBefore(DateTime(now.year, now.month, now.day))) {
          setState(() {
            allmissingAppointmentsCount++;
          });
        } else {
          setState(() {
            allupcomingAppointmentsCount++;
          });
        }
      }
    });

    print(allcompletedAppointmentsCount +
        allmissingAppointmentsCount +
        allupcomingAppointmentsCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.amber[200]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Appointment data ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton(
                    value: showWeeklyChart ?? true,
                    items: [
                      DropdownMenuItem(
                        child: Text('Weekly Chart'),
                        value: true,
                      ),
                      DropdownMenuItem(
                        child: Text('Overall Chart'),
                        value: false,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        showWeeklyChart = value ?? true;
                      });
                    },
                  ),
                ],
              ),
            ),
            //SizedBox(height: 10),
            showWeeklyChart ? buildWeeklyChart() : buildOverallChart(),
            SizedBox(height: 20),
            buildCompletedAppointmentsByWeekChart(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget buildWeeklyChart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(border: Border.all(width: 1.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Weekly overall record",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: completedAppointmentsCount.toDouble(),
                      title: completedAppointmentsCount.toString(),
                      color: Colors.green,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: missingAppointmentsCount.toDouble(),
                      title: missingAppointmentsCount.toString(),
                      color: Colors.red,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: upcomingAppointmentsCount.toDouble(),
                      title: upcomingAppointmentsCount.toString(),
                      color: Colors.blue,
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Completed appointments this week : ",
                    style: TextStyle(fontSize: 15)),
                Text("$completedAppointmentsCount",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Upcoming appointments this week : ",
                    style: TextStyle(fontSize: 15)),
                Text("$upcomingAppointmentsCount",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Missing appointments this week : ",
                    style: TextStyle(fontSize: 15)),
                Text("$missingAppointmentsCount",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOverallChart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(border: Border.all(width: 1.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Overall record",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: allcompletedAppointmentsCount.toDouble(),
                      title: allcompletedAppointmentsCount.toString(),
                      color: Colors.green,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: allmissingAppointmentsCount.toDouble(),
                      title: allmissingAppointmentsCount.toString(),
                      color: Colors.red,
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: allupcomingAppointmentsCount.toDouble(),
                      title: allupcomingAppointmentsCount.toString(),
                      color: Colors.blue,
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Completed appointments : ",
                    style: TextStyle(fontSize: 15)),
                Text("$allcompletedAppointmentsCount",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Upcoming appointments : ",
                    style: TextStyle(fontSize: 15)),
                Text("$allupcomingAppointmentsCount",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Missing appointments : ",
                    style: TextStyle(fontSize: 15)),
                Text("$allmissingAppointmentsCount",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCompletedAppointmentsByWeekChart() {
    return Container(
      //height: 500,
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Completed Appointments by Week',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: completedAppointmentsByWeek.values.isNotEmpty
                    ? completedAppointmentsByWeek.values
                        .reduce((value, element) =>
                            value > element ? value : element)
                        .toDouble()
                    : 0,
                barGroups: [
                  ...allDaysOfWeek.map((day) {
                    final count =
                        completedAppointmentsByWeek[day]?.toDouble() ?? 0;
                    final weekdays = day.split('-').map(int.parse).toList();
                    final date =
                        DateTime(weekdays[0], weekdays[1], weekdays[2]);
                    return BarChartGroupData(
                      x: allDaysOfWeek.indexOf(day),
                      barRods: [
                        BarChartRodData(
                          y: count,
                          colors: [Colors.green],
                        ),
                      ],
                    );
                  }),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) => TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    margin: 10,
                    rotateAngle: -30,
                    getTitles: (double value) {
                      final index = value.toInt();
                      if (index >= 0 && index < allDaysOfWeek.length) {
                        final day = allDaysOfWeek[index];
                        final weekdays = day.split('-').map(int.parse).toList();
                        final date =
                            DateTime(weekdays[0], weekdays[1], weekdays[2]);
                        return DateFormat('EEEE').format(date);
                      }
                      return '';
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) => TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
