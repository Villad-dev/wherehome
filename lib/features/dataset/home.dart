import 'package:wherehome/features/dataset/timetable.dart';

import 'Landlord.dart';

class Home {
  final String address;
  final String address_num;
  late final String flat_num;
  late final String postal_code;
  final String city;
  late final double lat;
  late final double long;
  final double price;
  final double area;
  final int rooms;
  late final Timetable timeTable;
  late final Landlord landlord;
  final String imagePath;

  Home(this.address, this.address_num, this.city, this.price, this.area, this.rooms, this.imagePath);
}