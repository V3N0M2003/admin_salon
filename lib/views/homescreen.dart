import 'package:admin_salon/views/appointment/appointments.dart';
import 'package:admin_salon/views/my%20salon/mysalon.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Salon Admin'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 15)),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                Container(
                    height: 60,
                    width: 60,
                    child: Image.asset('assets/icons/sal_profile.png')),
                Column(
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
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Appointment()));
                },
                child: Container(
                  height: 160,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(4, 4))
                      ]),
                  child: Column(
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
              //Padding(padding: EdgeInsets.only(left: 20)),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MySalon()));
                },
                child: Container(
                  height: 160,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(4, 4))
                      ]),
                  child: Column(
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
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Analytics',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
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
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total appointmets',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                '50',
                                style: TextStyle(fontSize: 20),
                              ),
                            ]),
                      ),
                      Container(
                        height: 70,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Revenue',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Rs 10000',
                                style: TextStyle(fontSize: 20),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 250,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.7),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
