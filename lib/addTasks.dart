import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/allTasks.dart';

//import 'package:medicarenew/forgot_password.dart';
//import 'package:medicarenew/navigation.dart';
//import 'package:medicarenew/sign_up.dart';
//import 'NetworkHandler.dart';

// ignore: must_be_immutable
class AddTask extends StatefulWidget {
  String s;
  AddTask(this.s, {super.key});
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  //List taskData = List.generate(3, (int index) => index*index, growable: true);
  late final _myBox = Hive.box('NewToDoBox');
  late Map<String, String> data;
  
  TextEditingController task_due = TextEditingController();
  TextEditingController date_due = TextEditingController();
  TextEditingController time_due = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: selectedDate, 
      firstDate: DateTime(2015,8),
      lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context, 
      initialTime: selectedTime);
    if (picked != null && picked != selectedTime){
      setState(() {
        selectedTime = picked;
      });
    };
  }

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/main_login_background.jpg"), fit: BoxFit.cover)),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 23, right: 20),
                  child: Text(
                    "Add your task...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.amber,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    controller: task_due,
                    style: TextStyle(color: Colors.amberAccent),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: Colors.amber, width: 1.0,),),
                      labelText: 'Task',
                      labelStyle: TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 20),
                          child: TextField(
                            controller: date_due,
                            style: TextStyle(color: Colors.amberAccent),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(color: Colors.amber, width: 1.0,),),
                              labelText: '${selectedDate.toLocal()}',
                              labelStyle: TextStyle(color: Colors.amberAccent),
                            ),
                          ),
                        ),
                      ),
                      //Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(height: 10.0,),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape:StadiumBorder(),
                        ),
                        child: Text('Select date'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 20),
                          child: TextField(
                            controller: time_due,
                            style: TextStyle(color: Colors.amberAccent),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(color: Colors.amber, width: 1.0,),),
                              labelText: '${selectedTime.format(context)}',
                              labelStyle: TextStyle(color: Colors.amberAccent),
                            ),
                          ),
                        ),
                      ),
                      //Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(height: 10.0,),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape:StadiumBorder(),
                        ),
                        child: Text('Select time'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
               
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: ElevatedButton(
                      onPressed: () async {
                        data = {
                          "task": task_due.text,
                          "date": selectedDate.toLocal().toString().split(' ')[0],
                          "time": selectedTime.format(context)
                        };
                        writeData(data);
                        Navigator.pushNamed(context, '/view');
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape:StadiumBorder(),
                      ),
                      child: const Text('Add task')),
                ),
                
                
              ],
            ),
          ),
        ),
      
      ),
    );
  }

  void writeData(Map<String , String> data){
    _myBox.add(data);
    print(_myBox.toMap());
  }
    
  
}

