// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/UpdateStudent.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final index;
  const Profile({super.key, required this.index});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final student = studentList[widget.index];
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), actions: [
        IconButton(
            onPressed: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => UpdateStudent(index: widget.index),
                )),
            icon: const Icon(Icons.edit))
      ]),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(children: [
            CircleAvatar(
              radius: 90,
              child: student.image.isEmpty
                  ? CircleAvatar(
                      radius: 90,
                      child: Text(
                        student.name[0],
                        style: const TextStyle(fontSize: 100),
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.file(
                        File(student.image),
                        width: 250,
                        height: 250,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              student.name,
              style: const TextStyle(fontSize: 35),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                color: const Color.fromARGB(248, 240, 232, 236),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    const Text(
                      "Contact",
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(student.mobile),
                    ),
                    ListTile(
                      leading: const Icon(Icons.mail),
                      title: Text(student.email),
                    ),
                  ]),
                ),
              ),
            )
          ]),
        )
      ]),
    );
  }
}
