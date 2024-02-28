import 'package:admin_salon/util/upcoming_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpcomingApointments extends StatefulWidget {
  const UpcomingApointments({super.key});

  @override
  State<UpcomingApointments> createState() => _UpcomingApointmentsState();
}

class _UpcomingApointmentsState extends State<UpcomingApointments> {
  DateTime today = DateTime.now();
  late String formattedToday =
      formattedToday = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            //.orderBy('selectedTimeSlot')
            .where('bookingDate', isGreaterThan: formattedToday)
            .where('complete', isEqualTo: "0")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No upcoming Appointments.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Column(
                children: [
                  UpcomingWidget(
                      date: data['bookingDate'].toString(),
                      timeSlot: data['selectedTimeSlot'].toString(),
                      serviceId: data['selectedHairstyle'],
                      userId: data['userId'],
                      id: document.id),
                  const SizedBox(
                    height: 5,
                  )
                ],
              );
            },
          );
        });
  }
}
