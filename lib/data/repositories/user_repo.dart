// User class with id field not marked as final and with a setter method

class User {
  String? id; // Removed 'final' keyword

  final String email;
  final int phoneNumber;
  final String password;

  User({
    this.id,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        email = json['email'] as String,
        phoneNumber = json['phoneNumber'] as int,
        password = json['password'] as String;

  Map<String, dynamic> toJson() => {
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
      };

  List<Object?> get props => [id, email, phoneNumber, password];
}
