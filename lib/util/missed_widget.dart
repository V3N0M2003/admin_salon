import 'package:admin_salon/util/missed_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MissedWidget extends StatelessWidget {
  final String date;
  final String timeSlot;
  final String serviceId;
  final String userId;
  final String id;

  const MissedWidget(
      {super.key,
      required this.date,
      required this.timeSlot,
      required this.serviceId,
      required this.userId,
      required this.id});
  Future<Map<String, dynamic>> fetchData(
      String serviceId, String userId) async {
    Map<String, dynamic> data = {};

    DocumentSnapshot serviceSnapshot = await FirebaseFirestore.instance
        .collection('services')
        .doc(serviceId)
        .get();

    if (serviceSnapshot.exists) {
      data['serviceName'] = serviceSnapshot['name'];
      data['category'] = serviceSnapshot['category'];
      data['price'] = serviceSnapshot['price'].toString();
    }

    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      data['userName'] =
          userSnapshot['firstName'] + ' ' + userSnapshot['secondName'];
      data['imageUrl'] = userSnapshot['file'];
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(serviceId, userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              MissedContainer(
                  date,
                  timeSlot,
                  snapshot.data!['userName'],
                  snapshot.data!['serviceName'],
                  snapshot.data!['category'],
                  snapshot.data!['imageUrl'],
                  snapshot.data!['price'],
                  id),
              const SizedBox(
                height: 10,
              )
            ],
          );
        }
      },
    );
  }
}
