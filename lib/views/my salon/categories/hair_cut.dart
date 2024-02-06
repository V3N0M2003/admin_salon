import 'package:admin_salon/util/service_list.dart';
import 'package:flutter/material.dart';

class HairCut extends StatefulWidget {
  const HairCut({super.key});

  @override
  State<HairCut> createState() => _HairCutState();
}

class _HairCutState extends State<HairCut> {
  @override
  Widget build(BuildContext context) {
    return const ServiceList('Hair cut');
  }
}
