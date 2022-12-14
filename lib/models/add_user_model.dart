class UserModel {
  String? id;
  String? name;
  int? age;
  DateTime? birthday;
  UserModel({this.id = '', this.name, this.age, this.birthday});
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'age': age, 'birthday': birthday};
}
