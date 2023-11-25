class StudentModel {
  int? id;
  String name;
  String email;
  String mobile;
  String image;

  StudentModel(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.image,
      this.id});

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final mobile = map['mobile'] as String;
    final email = map['email'] as String;
    final image = map['image'] as String;

    return StudentModel(
      id: id,
      name: name,
      email: email,
      mobile: mobile,
      image: image,
    );
  }
}
