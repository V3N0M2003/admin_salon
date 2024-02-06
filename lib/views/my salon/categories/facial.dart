import 'package:admin_salon/util/service_list.dart';
import 'package:flutter/material.dart';

class Facial extends StatefulWidget {
  const Facial({super.key});

  @override
  State<Facial> createState() => _FacialState();
}

class _FacialState extends State<Facial> {
  @override
  Widget build(BuildContext context) {
    return const ServiceList('Facial');
  }
}
