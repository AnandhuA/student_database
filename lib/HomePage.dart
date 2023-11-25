// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/ProfilePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    getStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "AddStudent");
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListView.separated(
            itemCount: studentList.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
                  height: 10,
                ),
            itemBuilder: (BuildContext context, int index) {
              final student = studentList[index];
              return ListTile(
                  leading: student.image.isEmpty
                      ? CircleAvatar(
                          child: Text(student.name[0]),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.file(
                            File(student.image),
                            width: 50,
                            height: 50,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text("Delete ${student.name}"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No")),
                                  TextButton(
                                      onPressed: () async {
                                        deleteStudent(student);
                                        await getStudents();
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            "HomePage",
                                            (route) => false);
                                      },
                                      child: const Text("Yes"))
                                ]);
                          });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  title: Text(student.name),
                  subtitle: Text(student.mobile),
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            index: index,
                          ),
                        ),
                      ));
            }),
      ),
    );
  }
}
