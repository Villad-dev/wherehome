import 'package:wherehome/data/repositories/home_repo.dart';

class Appointment {
  late Home home;
  late String owner;
  late String potentialClient;
  late String createdAt;
  late String time;

  Appointment({
    required this.home,
    required this.owner,
    required this.potentialClient,
    required this.createdAt,
    required this.time,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      home: Home.defined(json['home']),
      owner: json['owner'] as String,
      potentialClient: json['potential_client'] as String,
      createdAt: json['created_at'] as String,
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home.toJson(),
      'owner': owner,
      'potential_client': potentialClient,
      'created_at': createdAt,
      'time': time,
    };
  }
}
