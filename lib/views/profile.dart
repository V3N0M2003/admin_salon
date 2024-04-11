import 'package:admin_salon/util/textbox.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salon Profile'),
        backgroundColor: Colors.red,
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
          const SizedBox(height: 20),
          const Text(
            'Name : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextBox("SalonPro"),
          const SizedBox(height: 20),
          const Text(
            'Description : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextBox("Best in class salon in markett"),
          const SizedBox(height: 20),
          const Text(
            'Address : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextBox("Near VIIT college, Kondhwa - 411048"),
          const SizedBox(height: 100),
          SizedBox(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
          SizedBox(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
