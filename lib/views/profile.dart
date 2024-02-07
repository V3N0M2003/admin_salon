import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salon Profile'),
        backgroundColor: Colors.red, // Change the color according to your theme
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(
            height: 200,
            child: Image.network(
              'https://i.pinimg.com/originals/ec/94/87/ec948736ffcb1148bd82230ea899f4c8.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Salon Name',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'AAA Salon',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Salon Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'xxxxxxxx xxxxxx  xxxxxxx xxxxxxxx',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Salon Address',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'xxxxxx xxxxxx  xxxxxx xxxxx xxxx',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
