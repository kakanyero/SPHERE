
// The file in the 'lib/user.dart' to define a model class to represent user data
class User {
  final int? id;
  final String username;
  final String email;
  User({this.id, required this.username, required this.email});

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username, 'email': email};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], username: map['username'], email: map['email']);
  }
}














// class User {
//   int? id;
//   String name;
//   int age;

//   User({this.id, required this.name, required this.age});

//   Map<String, dynamic> toMap() {
//     return {'id': id, 'name': name, 'age': age};
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['id'],
//       name: map['name'],
//       age: map['age'],
//     );
//   }
// }