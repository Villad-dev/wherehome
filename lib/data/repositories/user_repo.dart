// ignore: public_member_api_docs

///User class
// ignore: must_be_immutable
class User {
  ///User constructor
  const User({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.password,
  });

  // ignore: public_member_api_docs
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        username = json['username'] as String,
        phoneNumber = json['phoneNumber'] as int,
        password = json['password'] as String;

  // ignore: public_member_api_docs
  final String id;

  // ignore: public_member_api_docs
  final String username;

  ///phone number
  final int phoneNumber;

  ///encrypted password
  final String password;

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'phoneNumber': phoneNumber,
        'password': password,
      };

  List<Object?> get props => [id, username, phoneNumber, password];
}
