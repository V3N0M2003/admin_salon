import 'package:admin_salon/views/appointment/categories/complete.dart';
import 'package:admin_salon/views/appointment/categories/missed.dart';
import 'package:admin_salon/views/appointment/categories/today.dart';
import 'package:admin_salon/views/appointment/categories/upcoming.dart';
import 'package:flutter/material.dart';

enum PageType { Today, Upcoming, Missed, Complete }

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  PageType _selectedPage = PageType.Today;

  void _navigateToPage(PageType pageType) {
    setState(() {
      _selectedPage = pageType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: Colors.red,
        //centerTitle: true,
        actions: [
          DropdownButton(
            value: _selectedPage,
            onChanged: (value) {
              _navigateToPage(value as PageType);
            },
            items: const [
              DropdownMenuItem(
                value: PageType.Today,
                child: Text('Today'),
              ),
              DropdownMenuItem(
                value: PageType.Upcoming,
                child: Text('Upcoming'),
              ),
              DropdownMenuItem(
                value: PageType.Missed,
                child: Text('Missed'),
              ),
              DropdownMenuItem(
                value: PageType.Complete,
                child: Text('Complete'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: _buildPageContent(),
      ),
    );
  }

  Widget _buildPageContent() {
    switch (_selectedPage) {
      case PageType.Today:
        return const TodayAppointment();
      case PageType.Upcoming:
        return const UpcomingApointments();
      case PageType.Missed:
        return const MissedApointments();
      case PageType.Complete:
        return const CompleteApointment();
    }
  }
}
