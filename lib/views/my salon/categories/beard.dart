import 'package:admin_salon/util/service_list.dart';
import 'package:flutter/material.dart';

class BeardCut extends StatefulWidget {
  const BeardCut({super.key});

  @override
  State<BeardCut> createState() => _BeardCutState();
}

class _BeardCutState extends State<BeardCut> {
  @override
  Widget build(BuildContext context) {
    return const ServiceList('Beard');
  }
}
