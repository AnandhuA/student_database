import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/ProfilePage.dart';

class UpdateStudent extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final index;
  const UpdateStudent({super.key, required this.index});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  late XFile file;
  String selectfile = "";
  @override
  Widget build(BuildContext context) {
    final student = studentList[widget.index];
    name.text = student.name;
    email.text = student.email;
    mobile.text = student.mobile;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Details"),
      ),
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 30),
            child: Form(
              key: formkey,
              child: Column(children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Your Name";
                    }
                    return null;
                  },
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.account_circle,
                    ),
                    label: const Text("Name"),
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Mobile Number";
                    } else if (value.length != 10) {
                      return "Enter valid Mobile Number";
                    }
                    return null;
                  },
                  controller: mobile,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    label: const Text("Mobile"),
                    hintText: "Mobile",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Email Address";
                    } else if (!value.contains("@gmail.com")) {
                      return "Enter Valid Email Address ";
                    }
                    return null;
                  },
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
                    label: const Text("Email"),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(children: [
                  TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.photo_camera),
                                      title: const Text("Camera"),
                                      onTap: () {
                                        ontap(context, ImageSource.camera);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text("Gallery"),
                                      onTap: () {
                                        ontap(context, ImageSource.gallery);
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: const Text("Add photo")),
                  SizedBox(
                    child: selectfile.isEmpty
                        ? const Text("")
                        : Image.file(
                            File(selectfile),
                            width: 60,
                            height: 40,
                          ),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      student.name = name.text;
                      student.email = email.text;
                      student.mobile = mobile.text;
                      student.image = selectfile;
                      updateimage(student);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(
                              index: widget.index,
                            ),
                          ));
                    }
                  },
                  child: const Text("Update"),
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  ontap(ctx, ImageSource cam) async {
    file = (await ImagePicker().pickImage(source: cam))!;
    setState(() {
      selectfile = file.path;
    });
  }
}
