import 'package:flutter/material.dart';
import 'package:todo/addTasks.dart';
import 'package:todo/allTasks.dart';


// ignore: must_be_immutable
class HeadPage extends StatefulWidget {
  int navigationIndex;
  HeadPage(this.navigationIndex, {super.key});
  @override
  State<HeadPage> createState() => _HeadPageState(navigationIndex);
}

class _HeadPageState extends State<HeadPage> {
  
  int navigationIndex = 0;
  int _selectedIndex = 0;
  _HeadPageState(int navigationIndex){
    _selectedIndex = navigationIndex;
  }

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(

        ),
        body: Center(
          
          child: _pages.elementAt(_selectedIndex),
        ),

        bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        backgroundColor: Colors.amber,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Enter',
          ),
        ],
        //selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      );

  }

  void _onItemTapped(int index) {
        setState(() {
          _selectedIndex = index;
      });
  }

  static final List<Widget> _pages = <Widget>[
    ViewAllTasks(),
    AddTask(""),
  ];
}
