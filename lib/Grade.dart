class Grade {
  String grade_id;
  String class_name;
  int grade1;
  int grade2;

  Grade(this.grade_id, this.class_name, this.grade1, this.grade2);
  
  factory Grade.fromJson(String key,Map<dynamic,dynamic> json) {
    return Grade(key, json["ders_adi"] as String, json["not1"] as int, json["not2"] as int);
  }
}