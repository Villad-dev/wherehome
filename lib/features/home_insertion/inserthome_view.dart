import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/controllers/http_controller.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/widgets/dialog_error.dart';
import 'package:wherehome/const/features.dart';
import 'package:wherehome/data/repositories/home_repo.dart';
import 'package:wherehome/data/repositories/timetable_repo.dart';
import 'package:wherehome/features/home_insertion/widgets/filter_features.dart';
import 'package:wherehome/features/home_insertion/widgets/switch_buttons_property_type.dart';
import 'package:wherehome/features/home_insertion/widgets/switch_buttons_rent_type.dart';
import 'package:wherehome/features/home_insertion/widgets/switch_buttons_room_number.dart';

import '../../common/providers/user_provider.dart';
import 'widgets/address_search_widget.dart';
import 'widgets/calendar_picker_insertion.dart';
import 'widgets/timepicker_insertion.dart';

class InsertHome extends StatefulWidget {
  const InsertHome({super.key});

  @override
  State<InsertHome> createState() => _InsertHomeState();
}

class _InsertHomeState extends State<InsertHome> {
  late final TextEditingController priceInputController;
  late final TextEditingController areaInputController;
  late final TextEditingController titleInputController;
  final TextEditingController addressSearchController = TextEditingController();
  int rooms = 1;
  String type = 'Rent';
  String buildingType = 'Apartment';
  late MapBoxPlace sugAdr;
  List<File> selectedImages = [];
  List<String> features = [];
  String? rentalFrequency = 'monthly';
  DateTimeRange? selectedDateRange;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int? intervalInMinutes;
  Timetable? timetable;

  @override
  void initState() {
    priceInputController = TextEditingController();
    areaInputController = TextEditingController();
    titleInputController = TextEditingController();
    super.initState();
  }

  Map<String, dynamic> prepareData() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    timetable = prepareTimetable();
    if (timetable == null) {
      showErrorDialog(context, 'Timetable is not chosen');
    }
    if (priceInputController.text.isEmpty) {
      showErrorDialog(context, 'Price is not chosen');
    }
    if (areaInputController.text.isEmpty) {
      showErrorDialog(context, 'Area is not chosen');
    }

    return prepareHome(
        titleInputController.text,
        type,
        type == 'Sell' ? null : rentalFrequency,
        sugAdr.placeName!,
        'addressNum',
        'postalCode',
        'city',
        'Country',
        sugAdr.geometry!.coordinates.lat,
        sugAdr.geometry!.coordinates.long,
        double.tryParse(priceInputController.text)!,
        double.tryParse(areaInputController.text)!,
        buildingType,
        rooms,
        features,
        timetable!,
        userProvider.homeOwner!.id!);
  }

  void insertHome(HttpController api) async {
    final home = prepareData();
    await api.sendPostRequest(
      'homes',
      null,
      home,
      (success) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final userId = userProvider.user?.id;
        final responseBody = jsonDecode(success.body);
        final homeId = responseBody['_id'];
        final Map<String, String> headers = {
          'Content-Type': 'multipart/form-data',
          'userId': userId!,
          'homeId': 'homeId_$homeId',
          '_id': homeId.toString()
        };
        await api.uploadImages(
          'upload',
          selectedImages,
          headers,
          (onSuccess) async {
            await api.sendPutRequest(
                'homeowner/${userProvider.homeOwner!.id}',
                {
                  'Authorization': 'Bearer ${userProvider.apiToken}',
                  'list': 'homes'
                },
                jsonDecode(onSuccess.body), (success) {
              Navigator.pop(context, 'home_added');
            }, (failure) {
              showErrorDialog(context, failure.body);
            });
          },
          (onFailure) {
            showErrorDialog(context, onFailure.body);
          },
        );
      },
      (fail) {
        showErrorDialog(context, fail.body);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final api = HttpControllerInherited.of(context).api;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'add_home',
        ).tr(),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () async {
            if (selectedImages.isEmpty) {
              showErrorDialog(context, 'Choose image');
            } else {
              //print('Features $features');
              insertHome(api);
            }
          },
          child: Text(
            'add_button_add'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildImageList(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '${selectedImages.length}/8',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'add_title'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextField(
                controller: titleInputController,
                decoration: const InputDecoration(
                  hintText: 'Enter the title',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SwitchHomeType(
            onSwitched: (String newType) {
              setState(() {
                type = newType;

                //print(type);
              });
            },
          ),
          if (type == 'Rent') ...[
            const SizedBox(height: 16),
            const Text(
              'Rental Frequency',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButton<String>(
              value: rentalFrequency,
              items: const [
                DropdownMenuItem(
                  value: 'daily',
                  child: Text('Daily'),
                ),
                DropdownMenuItem(
                  value: 'weekly',
                  child: Text('Weekly'),
                ),
                DropdownMenuItem(
                  value: 'monthly',
                  child: Text('Monthly'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  rentalFrequency = newValue!;
                });
              },
            ),
          ],
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'add_location'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AddressSearchWidget(onSelected: (MapBoxPlace suggestion) {
                setState(() {
                  sugAdr = suggestion;
                });
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'add_price'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: priceInputController,
                      decoration: InputDecoration(
                        hintText: 'add_price_enter'.tr(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'add_area'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: areaInputController,
                      decoration: const InputDecoration(
                        hintText: 'm2',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'add_property_type'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SwitchPropertyType(
                onSwitched: (String type) {
                  setState(() {
                    buildingType = type;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'add_rooms'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SwitchButtonsRooms(
                onSwitched: (int number) {
                  setState(() {
                    rooms = number;
                  });
                },
              )
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'add_filters'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FilterFeatures(
                features: listOfeatures,
                onSelectionChanged: (selected) {
                  features.addAll(selected);
                  //print('Selected features: $selected');
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CalendarPickerInputField(
                  availableFrom: DateTime.now(),
                  availableTo: DateTime.now().add(const Duration(days: 90)),
                  onDateSelected: (DateTimeRange dateRange) {
                    selectedDateRange = dateRange;
                  },
                ),
                TimePickerInsertField(
                  onFromTimeSelected: (TimeOfDay startT) {
                    startTime = startT;
                  },
                  onToTimeSelected: (TimeOfDay endT) {
                    endTime = endT;
                  },
                  onIntervalSelected: (int interval) {
                    intervalInMinutes = interval;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Timetable? prepareTimetable() {
    if (selectedDateRange != null &&
        startTime != null &&
        endTime != null &&
        intervalInMinutes != null) {
      if (selectedDateRange!.start.isAfter(selectedDateRange!.end)) {
        showErrorDialog(context, 'End date must be after start date.');
        return null;
      }

      DateTime startDayTime = selectedDateRange!.start.setTime(startTime!);
      DateTime endDayTime = selectedDateRange!.end.setTime(endTime!);

      if (endDayTime.isBefore(startDayTime)) {
        showErrorDialog(context, 'End time must be after start time.');
        return null;
      }

      if (intervalInMinutes! < 10) {
        showErrorDialog(context, 'Interval must be at least 10 minutes.');
        return null;
      }

      return Timetable(
        startDayTime: startDayTime,
        endDayTime: endDayTime,
        interval: intervalInMinutes!,
      );
    } else {
      showErrorDialog(context, 'All timetable fields must be selected.');
      return null;
    }
  }

  Map<String, dynamic> prepareHome(
    //int _id,
    String title,
    String type,
    String? rentalFrequency,
    String address,
    String addressNum,
    String postalCode,
    String city,
    String country,
    double lat,
    double long,
    double price,
    double area,
    String buildingType,
    int rooms,
    List<String> features,
    Timetable timetable,
    String homeOwnerId,
  ) {
    Home home = Home(
        //_id,
        title,
        type,
        rentalFrequency,
        address,
        addressNum,
        postalCode,
        city,
        country,
        lat,
        long,
        price,
        area,
        buildingType,
        rooms,
        features,
        timetable,
        homeOwnerId);
    home.imagePath = [];

    return home.toJson();
  }

  Future<void> localFilesPermission() async {
    PermissionStatus result = await Permission.mediaLibrary.request();
    if (result.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          if (selectedImages.length < 8) {
            selectedImages.add(
              File(pickedFile.path),
            );
          }
        });
      }
    }
  }

  Widget buildImageList() {
    List<Widget> imageWidgets = [];

    if (selectedImages.isEmpty) {
      return GestureDetector(
        onTap: () async {
          await localFilesPermission();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            Icon(
              Icons.add_rounded,
              color: Theme.of(context).colorScheme.background,
              size: 100,
            ),
          ],
        ),
      );
    } else {
      for (int i = 0; i < selectedImages.length; i++) {
        imageWidgets.add(
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            width: 200,
            height: 200,
            child: Image.file(
              selectedImages[i],
              fit: BoxFit.cover,
            ),
          ),
        );
      }

      if (selectedImages.length < 8) {
        imageWidgets.add(
          GestureDetector(
            onTap: () async {
              await localFilesPermission();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                color: Theme.of(context).colorScheme.background,
                Icons.add_rounded,
                size: 100,
              ),
            ),
          ),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: imageWidgets,
        ),
      );
    }
  }
}
