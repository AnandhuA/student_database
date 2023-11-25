import 'package:sqflite/sqflite.dart';
import 'package:student_database/Db/model.dart';

List<StudentModel> studentList = [];

late Database db;

Future<void> dataBase() async {
  db = await openDatabase(
    "studentDb",
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,mobile TEXT,email TEXT,image TEXT)");
    },
  );
}

Future<void> getStudents() async {
  final values = await db.rawQuery('SELECT * FROM student');
  studentList.clear();
  for (var map in values) {
    final student = StudentModel.fromMap(map);
    studentList.add(student);
  }
}

void addStudent(StudentModel val) async {
  await db.rawInsert(
      'INSERT INTO student (name,mobile,email,image) VALUES (?,?,?,?)',
      [val.name, val.mobile, val.email, val.image]);
}

void deleteStudent(StudentModel id) {
  db.rawDelete("DELETE FROM student WHERE id =?", [id.id]);
}

void updateimage(StudentModel val) async {
  await db.rawUpdate(
      'UPDATE student SET name = ? ,mobile = ? ,email = ?,image =? WHERE id = ?',
      [val.name, val.mobile, val.email, val.image, val.id]);
}
