import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TimeEventScreen extends StatelessWidget {
  const TimeEventScreen({super.key, this.placeID, this.name});

  final int? placeID;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('TimeEvnet'),
    );
  }
}
