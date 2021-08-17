import 'package:flutter/material.dart';
import 'package:probistics/widgets/continuous_options.dart';
import 'package:probistics/widgets/discrete_options.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final tabs = [
    DiscreteList(),
    ContinuousList(),
  ];

  final navBarItems = [
    const BottomNavigationBarItem(
      label: "Discrete",
      icon: Icon(Icons.all_out),
    ),
    const BottomNavigationBarItem(
      label: "Continuous",
      icon: Icon(Icons.all_inclusive),
    ),
  ];

  void _setSelectedIndex(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Probistics", 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ),
          titleSpacing: NavigationToolbar.kMiddleSpacing,
          backgroundColor: Colors.black,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(100.0, 0.0, 0.0, 0.0),
            child: Icon(Icons.bar_chart, color: Colors.blueAccent)
          ),
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: navBarItems,
          onTap: (int index) => _setSelectedIndex(index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
