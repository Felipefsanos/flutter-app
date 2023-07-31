import 'package:flutter/material.dart';
import 'package:flutter_menu/pages/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatelessWidget {
  const Account({super.key});



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton(
          onPressed: () => { },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(Icons.logout, color: Colors.red),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text('Sair'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
