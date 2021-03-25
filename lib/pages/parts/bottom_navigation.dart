import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int) notifyParent;

  BottomNavigation({this.notifyParent});

  @override
  State<StatefulWidget> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      widget.notifyParent(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.power_settings_new_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: "",
        ),
      ],
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
      currentIndex: _currentIndex,
    );
  }
}
