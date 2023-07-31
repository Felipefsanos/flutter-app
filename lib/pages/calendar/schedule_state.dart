import 'package:flutter/material.dart';
import 'package:flutter_menu/pages/calendar/schedule.dart';
import 'package:flutter_menu/pages/calendar/schedule_tile_item.dart';

class ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: const ScheduleTileItem(
            day: 1,
            month: 'Novembro',
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const ScheduleTileItem(
            month: 'Novembro',
          ),
        ),
      ],
    );
  }
}
