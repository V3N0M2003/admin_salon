import 'package:admin_salon/views/my%20salon/add_service.dart';
import 'package:admin_salon/views/my%20salon/categories/beard.dart';
import 'package:admin_salon/views/my%20salon/categories/facial.dart';
import 'package:admin_salon/views/my%20salon/categories/hair_cut.dart';
import 'package:admin_salon/views/my%20salon/categories/others.dart';
import 'package:flutter/material.dart';

class MySalon extends StatefulWidget {
  const MySalon({super.key});

  @override
  State<MySalon> createState() => _MySalonState();
}

class _MySalonState extends State<MySalon> {
  int _pageIndex = 0;
  List pages = [
    HairCut(),
    BeardCut(),
    Facial(),
    OtherServices(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        backgroundColor: Colors.red,
      ),
      body: pages[_pageIndex],
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddService()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          heroTag: 'addButton',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        elevation: 10,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cut),
            label: 'Hair-Cut',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/beard.png')),
            label: 'Beard',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/facial.png')),
            label: 'Facial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            label: 'Others',
          ),
        ],
      ),
    );
  }
}
