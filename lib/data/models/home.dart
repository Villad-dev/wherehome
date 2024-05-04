import 'package:wherehome/data/models/timetable.dart';

import 'Landlord.dart';

class Home {
  final String address;
  final String addressNum;
  late final String flatNum;
  late final String postalCode;
  final String city;
  late final double lat;
  late final double long;
  final double price;
  final double area;
  final int rooms;
  late final Timetable timeTable;
  late final Landlord landlord;
  final String imagePath;

  Home(this.address, this.addressNum, this.city, this.price, this.area, this.rooms, this.imagePath);
}