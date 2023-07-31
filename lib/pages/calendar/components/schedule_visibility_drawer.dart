import 'package:flutter/material.dart';

class ScheduleVisibilityDrawer extends StatelessWidget {

  const ScheduleVisibilityDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const <Widget> [
          Text('TESTE')
        ],
      ),
    );
  }
}