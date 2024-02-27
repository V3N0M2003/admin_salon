import 'package:flutter/material.dart';

class ServiceContainer extends StatelessWidget {
  final String name;
  final String gender;
  final String imageUrl;
  final num price;
  const ServiceContainer(this.name, this.gender, this.imageUrl, this.price,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      height: 140,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          //    topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          //    bottomRight: Radius.circular(10)
        ),
        //border: Border.all(width: 0.7),
        //boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(4, 4))]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                height: 130,
                width: 130,
                fit: BoxFit.contain,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    children: [
                      const Text(
                        'Name   : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(' $name', style: const TextStyle(fontSize: 18))
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Gender : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(' $gender', style: const TextStyle(fontSize: 18))
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Price    : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(' Rs $price', style: const TextStyle(fontSize: 18))
                    ],
                  ),
                ],
              ),
            ],
          ),
          /*Icon(
            Icons.arrow_circle_right,
            color: Colors.black,
            size: 40,
          ),*/
          //Padding(padding: EdgeInsets.only(right: 5))
        ],
      ),
    );
  }
}
