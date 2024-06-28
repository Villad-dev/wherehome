class User {
  String? id;
  String? email;
  final String phoneNumber;

  User({
    this.id,
    this.email,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Map<String, String> toJson(String password) => {
        'phoneNumber': phoneNumber,
        'password': password,
      };

  Map<String, String> toHomeOwner() => {
        'id': id!,
        'phoneNumber': phoneNumber,
        'email': email!,
      };

  Map<String, String> toJsonWithEmail(String email, String password) => {
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
      };

  List<Object?> get props => [id, email, phoneNumber];
}
