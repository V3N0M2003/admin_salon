import 'package:admin_salon/util/today_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodayAppointment extends StatefulWidget {
  const TodayAppointment({super.key});

  @override
  State<TodayAppointment> createState() => _TodayAppointmentState();
}

class _TodayAppointmentState extends State<TodayAppointment> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //late String? currentUserId;
  DateTime today = DateTime.now();
  late String formattedToday =
      formattedToday = "${today.year}-${today.month}-${today.day}";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            //.orderBy('selectedTimeSlot')
            .where('bookingDate', isEqualTo: formattedToday)
            .where('complete', isEqualTo: "0")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Appointments Today.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Column(
                children: [
                  TodayWidget(
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
