import 'package:flutter/material.dart';
import 'package:flutter_menu/pages/account/account.dart';
import 'package:flutter_menu/pages/calendar/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _navigationSelectedIndex = 0;

  void logout(context) {
    var prefs = SharedPreferences.getInstance();

    prefs.then((prf) => prf.clear());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  static const List<Widget> _navigationWidget = <Widget>[Schedule()];

  void _onNavigationTapped(int index) {
    setState(() {
      _navigationSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Título do app"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print("Ação de click no botão");
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
      body: Center(
        child: _navigationWidget.elementAt(_navigationSelectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationSelectedIndex,
        onTap: _onNavigationTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Conta',
              activeIcon: Icon(Icons.person_rounded))
        ],
      ),
    );
  }
}
