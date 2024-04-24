// ignore_for_file: public_member_api_docs

enum HomeType { renting, selling }

class Home {

  Home(this.type, this.title, this.description, this.price, this.location,
      this.calendar, this.images, this.createdBy,);

  late HomeType type;
  late String title;
  late String description;
  late double price;
  late Object location;
  late Object calendar;
  late List<String> images;
  late Object createdBy;
}
