import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ViewAllTasks extends StatefulWidget {
  //List taskData =[]; 
  ViewAllTasks({super.key});

  @override
  State<ViewAllTasks> createState() => _ViewAllTasksState();
}

class _ViewAllTasksState extends State<ViewAllTasks> with TickerProviderStateMixin{
  late Box _myBox;
  late List<String> tasks;

  late Map items;
  late List taskDataList =[];



  @override
  void initState() {
    super.initState();
    _myBox = Hive.box('NewToDoBox');
    for(int i = 0; i < getBoxLength(); i++){
      items = readData(i);
      print(items);
      taskDataList.add(items);
    }


  }



  Widget rowItemNormal(context, index, String taskName, String taskDate, String taskTime) {
    DateTime dt1 = DateTime.parse("$taskDate $taskTime:00");
    DateTime dt2 = DateTime.now();
    Duration diff = dt2.difference(dt1);

    String message='';
    if(diff.inSeconds>0){
      message = "Over due";
    }else{
      message = "";
      diff = diff*(-1);
    }

    int days = diff.inDays;
    int hours = diff.inHours % 24;
    int minutes = diff.inMinutes % 60;
    
    
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20,top: 3, bottom: 3),
        ),
        Hero(
          tag: 'ListTile-Hero',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  deleteData(index);
                  Navigator.pushNamed(context, '/view');
                },
              ),
              title: Text('$taskName | $message: $days days $hours h $minutes min'),
              subtitle: Text('Date: $taskDate   Time: $taskTime'),
              tileColor: Colors.amber[300],
              
            ),
          ),
        ),
      ],
    );
  }


  Widget showListNormal(int number2, List taskDataList) {
    
    return ListView.builder(
      padding: const EdgeInsets.all(6),
      itemCount: number2,//tasks.length,
      itemBuilder: (context, index) {
        return rowItemNormal(context, index, taskDataList[index]['name'], taskDataList[index]['date'], taskDataList[index]['time']);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/images/main_login_background.jpg"), fit: BoxFit.cover)),
        child:Column(
          children:<Widget>[
          Flexible(child: showListNormal(getBoxLength(),taskDataList)),])
      ),
    );
  }

  String readDataName(int index){
    var data = _myBox.getAt(index);
    return data['task'];
  }

  String readDataDate(int index){
    var data = _myBox.getAt(index);
    return data['date'];
  }

  String readDataTime(int index){
    var data = _myBox.getAt(index);
    return data['time'];
  }

  Map<String, String> readData(int index){
    Map<String, String> newData = {
      "name":readDataName(index),
      "date":readDataDate(index),
      "time":readDataTime(index),
    };

    return newData;
  }

  int getBoxLength(){
    return _myBox.length;
  }

  void deleteData(int index){
    _myBox.deleteAt(index);
    taskDataList.removeAt(index);
  } 


}