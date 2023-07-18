class ApiUser {
  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String position;
  final String login;
  final String email;
  final String phone;

  ApiUser.fromApi(Map<String, dynamic> map)
      : id = map['id'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        middleName = map['middleName'],
        position = map['position'],
        login = map['login'],
        email = map['email'],
        phone = map['phone'];
}
