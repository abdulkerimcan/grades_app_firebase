# Grades App by Flutter



## About The Project

This app calculates the average  of the grades. In the application you can add the name of the course,the first grade and the last grade. And most recently, it shows the overall average in the AppBar. And you can also delete this course,update the notes, or enter a new course. I keep this data thanks to Firebase Realtime. <br>

Thanks to the following code, I can access the table in the database by creating a reference.
```dart
var refWords = FirebaseDatabase.instance.ref().child("notlar");
```


![image](https://user-images.githubusercontent.com/79968953/160401978-b5c7e9ca-ebba-4798-8b88-16f9f3ceef61.png)
I used the StreamBuilder structure to view our data in a list.

```dart
 body: StreamBuilder<DatabaseEvent>(
        stream: refWords.onValue,
        builder: (context, event) {
          if (event.hasData) {
            var list = <Grade>[];
            var datas = event.data!.snapshot.value as dynamic;
            if(datas != null) {
            .
            .
            .
            .
            
```


![image](https://user-images.githubusercontent.com/79968953/160402694-9b56ded9-dddd-4d2c-a8fc-f39e5874842a.png)

Thanks to the code below, I can save a new data in firebase.

Thanks to the following code, I can access the table in the database by creating a reference.

```dart
Future<void> save(String className,int grade1,int grade2) async {
    var info = HashMap<String,dynamic>();
    info["ders_adi"] = className;
    info["not1"] = grade1;
    info["not2"] = grade2;
    info["not_id"] = "";
    refGrades.push().set(info);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
```

![image](https://user-images.githubusercontent.com/79968953/160402759-174b293d-b86e-4862-bc5a-5a627765f73a.png)

Thanks to the following code, I can delete the data in the database according to its id.


```dart
Future<void> delete(String grade_id) async {
    refGrades.child(grade_id).remove();

    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
```

Thanks to the following code, I can update the data in the database according to its id.

```dart
Future<void> update(String grade_id,String className,int grade1,int grade2) async {
    var info = HashMap<String,dynamic>();
    info["ders_adi"] = className;
    info["not1"] = grade1;
    info["not2"] = grade2;

    refGrades.child(grade_id).update(info);

    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

```
