import 'package:flutter/material.dart';

class ScheduleTileItem extends StatelessWidget {
  final int? day;
  final String month;

  const ScheduleTileItem({super.key, this.day, required this.month});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(month),
        Row(
          children: const <Widget>[
            Icon(
              Icons.circle,
              size: 8.0,
              color: Colors.deepPurple,
            )
          ],
        ),
        Text(day == null ? '' : day.toString()),
      ],
    );
  }
}
