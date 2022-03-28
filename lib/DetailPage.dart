import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import 'Grade.dart';
import 'main.dart';

class DetailPage extends StatefulWidget {
  Grade grade;


  DetailPage({required this.grade});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var tfClassName = TextEditingController();
  var tfGrade1 = TextEditingController();
  var tfGrade2 = TextEditingController();
  var refGrades = FirebaseDatabase.instance.ref().child("notlar");

  Future<void> delete(String grade_id) async {
    refGrades.child(grade_id).remove();

    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  Future<void> update(String grade_id,String className,int grade1,int grade2) async {
    var info = HashMap<String,dynamic>();
    info["ders_adi"] = className;
    info["not1"] = grade1;
    info["not2"] = grade2;

    refGrades.child(grade_id).update(info);

    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  void initState() {
    super.initState();
    var grade = widget.grade;
    tfClassName.text = grade.class_name;
    tfGrade1.text = grade.grade1.toString();
    tfGrade2.text = grade.grade2.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        actions: [
          TextButton(onPressed: () {
            delete(widget.grade.grade_id);
          }, child: Text("Delete",style: TextStyle(color: Colors.white),)),
          TextButton(onPressed: () {
            update(widget.grade.grade_id, tfClassName.text, int.parse(tfGrade1.text), int.parse(tfGrade2.text));
          }, child: Text("Update",style: TextStyle(color: Colors.white)))
        ],
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
    );
  }
}
