import 'package:wherehome/data/repositories/user_repo.dart';

import 'home_repo.dart';

class HomeOwner {
  String? id;
  User user;
  String? ownerName;
  List<Home>? homes;
  List<Home>? favourite;

  HomeOwner({
    this.id,
    required this.user,
    this.ownerName,
    this.homes,
    this.favourite,
  });

  static HomeOwner fromJson(Map<String, dynamic> json) {
    return HomeOwner(
      id: json['_id'],
      user: User.fromJson(json['user']),
      ownerName: json['ownerName'],
      homes: (json['homes'] as List<dynamic>?)?.isEmpty == false
          ? Home.toListFromJson(json['homes'])
          : [],
      favourite: (json['favourite'] as List<dynamic>?)?.isEmpty == false
          ? Home.toListFromJson(json['favourite'])
          : [],
    );
  }

  Map<String, dynamic> toAppointmentJson() {
    return {
      'id': id,
      'user': user,
      'ownerName': ownerName,
      'homes': homes,
      'favourite': favourite
    };
  }

  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      'user': user.toHomeOwner(),
      //'ownerName': ownerName,
    };
  }
}
