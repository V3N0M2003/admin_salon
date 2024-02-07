import 'package:admin_salon/util/complete_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompleteApointment extends StatefulWidget {
  const CompleteApointment({super.key});

  @override
  State<CompleteApointment> createState() => _CompleteApointmentState();
}

class _CompleteApointmentState extends State<CompleteApointment> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            //.orderBy('selectedTimeSlot')
            .where('complete', isEqualTo: "1")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nothing To display.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Column(
                children: [
                  CompleteWidget(
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
