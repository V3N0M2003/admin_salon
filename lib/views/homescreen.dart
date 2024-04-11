import 'package:admin_salon/views/Analytics/analyticcontainer.dart';
import 'package:admin_salon/views/Analytics/analytics.dart';
import 'package:admin_salon/views/appointment/appointments.dart';
import 'package:admin_salon/views/my%20salon/mysalon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SalonPro'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const Padding(padding: EdgeInsets.only(top: 15)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 10)),
                SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset('assets/icons/sal_profile.png')),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      'Hey',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(
                      'Wel-Come to salon',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    )
                  ],
                ),
                /*Icon(
                  Icons.emoji_people,
                  size: 50,
                  color: const Color.fromARGB(255, 247, 78, 66),
                ),*/
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Appointment()));
                },
                child: Container(
                  height: 160,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.7),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, offset: Offset(4, 4))
                      ]),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.green,
                        size: 80,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Appointments',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MySalon()));
                },
                child: Container(
                  height: 160,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.7),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, offset: Offset(4, 4))
                      ]),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/icons/mysalon.png'),
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'My Salon',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  child: const Text(
                    'Analytics',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Analytics(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_circle_right))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.7),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: FutureBuilder<int>(
                        future: count(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            int bookingCount = snapshot.data ?? 0;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total appointments',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  '$bookingCount',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.7),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: FutureBuilder<int>(
                        future: sum(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            int revenue = snapshot.data ?? 0;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Earnings',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  '$revenue',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CompletedAppointmentsGraph()
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<int> count() async {
  QuerySnapshot countQuery = await FirebaseFirestore.instance
      .collection('bookings')
      .where('complete', isEqualTo: "1")
      .get();

  return countQuery.docs.length;
}

Future<int> sum() async {
  QuerySnapshot bookingQuery = await FirebaseFirestore.instance
      .collection('bookings')
      .where('complete', isEqualTo: "1")
      .get();

  int totalPrice = 0;
  for (QueryDocumentSnapshot bookingDoc in bookingQuery.docs) {
    String serviceId = bookingDoc['selectedHairstyle'];
    DocumentSnapshot serviceDoc = await FirebaseFirestore.instance
        .collection('services')
        .doc(serviceId)
        .get();

    int price = serviceDoc['price'];
    totalPrice += price;
  }
  return totalPrice;
}
