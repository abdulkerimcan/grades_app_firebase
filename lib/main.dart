import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'AddGradePage.dart';
import 'DetailPage.dart';
import 'Grade.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var refGrades = FirebaseDatabase.instance.ref().child("notlar");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Home Page",style: TextStyle(color: Colors.white,fontSize: 16.0),),
            StreamBuilder<DatabaseEvent>(
              stream: refGrades.onValue,
              builder: (context,event) {
                if(event.hasData) {
                  var gradesList = <Grade>[];
                  var datas = event.data!.snapshot.value as dynamic;
                  if(datas != null) {
                    datas.forEach((key,object) {
                      var grade = Grade.fromJson(key, object);
                      gradesList.add(grade);
                    });
                  }


                  double avg = 0.0;
                  if(!gradesList.isEmpty) {
                    double sum = 0.0;

                    for(var n in gradesList) {
                      sum = sum + (n.grade1 + n.grade2)/2;
                    }
                    avg = sum/ gradesList.length;
                  }

                  return Text("Average : $avg",style: TextStyle(color: Colors.white,fontSize: 12.0));

                } else {
                  return Text("Average : 0",style: TextStyle(color: Colors.white,fontSize: 12.0));
                }
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: refGrades.onValue,
        builder: (context,event) {
          if(event.hasData) {
            var list = <Grade>[];
            var datas = event.data!.snapshot.value as dynamic;
            if(datas != null) {
              datas.forEach((key,object) {
                var grade = Grade.fromJson(key, object);
                list.add(grade);
              });
            }

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context,index) {
                var grade = list[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(grade: grade,)));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${grade.class_name}",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("${grade.grade1}"),
                          Text("${grade.grade2}")
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else {
            print("veri yok");
            return Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddGradePage()));

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
