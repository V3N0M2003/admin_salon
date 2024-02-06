import 'package:admin_salon/util/service_list.dart';
import 'package:flutter/material.dart';

class OtherServices extends StatefulWidget {
  const OtherServices({super.key});

  @override
  State<OtherServices> createState() => _OtherServicesState();
}

class _OtherServicesState extends State<OtherServices> {
  @override
  Widget build(BuildContext context) {
    return const ServiceList('Other');
  }
}
