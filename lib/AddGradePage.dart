import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class AddGradePage extends StatefulWidget {
  const AddGradePage({Key? key}) : super(key: key);

  @override
  _AddGradePageState createState() => _AddGradePageState();
}

class _AddGradePageState extends State<AddGradePage> {

  var tfClassName = TextEditingController();
  var tfGrade1 = TextEditingController();
  var tfGrade2 = TextEditingController();
  var refGrades = FirebaseDatabase.instance.ref().child("notlar");

  Future<void> save(String className,int grade1,int grade2) async {
    var info = HashMap<String,dynamic>();
    info["ders_adi"] = className;
    info["not1"] = grade1;
    info["not2"] = grade2;
    info["not_id"] = "";
    refGrades.push().set(info);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Grade"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "Class Name",
                ),
                controller: tfClassName,
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: "First Grade",
                ),
                controller: tfGrade1,
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: "Final Grade",
                ),
                controller: tfGrade2,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          save(tfClassName.text,int.parse(tfGrade1.text), int.parse(tfGrade2.text));
        },
        tooltip: 'Add Lesson',
        icon : const Icon(Icons.save),
        label: Text("Save"),
      ),
    );
  }
}
