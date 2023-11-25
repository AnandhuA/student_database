import 'package:flutter/material.dart';
import 'package:student_database/AddStudent.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await dataBase();
  await getStudents();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: const Color.fromARGB(255, 251, 245, 1000),
          primaryColor: Colors.deepPurple),
      home: const HomePage(),
      routes: {
        "HomePage": (context) => const HomePage(),
        "AddStudent": (context) => const AddStudent(),
        //"Profile": (context) =>  Profile()
      },
    );
  }
}
