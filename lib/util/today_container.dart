import 'package:flutter/material.dart';

class TodayContainer extends StatelessWidget {
  final String date;
  final String time;
  final String username;
  final String servicename;
  final String category;
  final String imgUrl;
  final String price;
  const TodayContainer(this.date, this.time, this.username, this.servicename,
      this.category, this.imgUrl, this.price,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      //padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          border: Border.all(width: 0.7),
          boxShadow: const [
            BoxShadow(color: Colors.grey, offset: Offset(4, 4))
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imgUrl),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height: 10),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Customer Name :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(username)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Service Name :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(servicename)
                    ],
                  ),
                  //Text("Service Name : $servicename"),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Category :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(category)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Appointment date : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(date)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Scheduled time : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(time)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Amount ( Rs ) : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(price),
                    ],
                  ),
                  //const Text(                  '_____________________________________________________________'),

                  //const SizedBox(height: 10),
                  /*Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.check_circle_outlined),
                      label: Text("Mark as Done"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Change button color
                      ),
                    ),
                  )*/
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: const BorderRadius.only(
                      //topLeft: Radius.circular(10),
                      //topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  border: Border.all(width: 0.7),
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, offset: Offset(4, 4))
                  ]),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    "  Mark as Done",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
