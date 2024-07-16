import 'timetable_repo.dart';

class Home {
  late final int _id;
  late final String title;
  late final String type;
  late final String? rentalFrequency;
  late final String address;
  late final String addressNum;
  late final String postalCode;
  late final String city;
  late final String country;
  late final double lat;
  late final double long;
  late final double price;
  late final double area;
  late final String buildingType;
  late final int rooms;
  late final List<dynamic>? features;
  late final Timetable timetable;
  late final String homeOwner;
  late List<dynamic> imagePath;

  Home(
    this.title,
    this.type,
    this.rentalFrequency,
    this.address,
    this.addressNum,
    this.postalCode,
    this.city,
    this.country,
    this.lat,
    this.long,
    this.price,
    this.area,
    this.buildingType,
    this.rooms,
    this.features,
    this.timetable,
    this.homeOwner,
  );

  Home.defined(Map<String, dynamic> json) {
    if (json.containsKey('_id')) {
      _id = json['_id'];
    }
    title = json['title'];
    type = json['type'];
    rentalFrequency = json['rentalFrequency'];
    buildingType = json['buildingType'];
    address = json['address'];
    addressNum = json['addressNum'];
    postalCode = json['postalCode'];
    city = json['city'];
    country = json['country'];
    lat = json['lat'];
    long = json['long'];
    price = json['price'];
    area = json['area'];
    rooms = json['rooms'];
    timetable = Timetable.fromJson(json['timetable']);
    homeOwner = json['homeOwner'];
    imagePath = json['imagePath'] ?? ['assets/images/empty_image.png'];
    features = json['features'] as List<dynamic>;
  }

  static List<Home> toListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Home.defined(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'rentalFrequency': rentalFrequency,
      'buildingType': buildingType,
      'address': address,
      'addressNum': addressNum,
      'postalCode': postalCode,
      'city': city,
      'country': country,
      'lat': lat,
      'long': long,
      'price': price,
      'area': area,
      'rooms': rooms,
      'timetable': timetable.toJson(),
      'homeOwner': homeOwner,
      'imagePath': imagePath,
      'features': features,
    };
  }
}
