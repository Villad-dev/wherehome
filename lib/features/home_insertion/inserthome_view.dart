import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:wherehome/features/home_insertion/widgets/filter_features.dart';
import 'package:wherehome/features/home_insertion/widgets/switch_buttons_property_type.dart';
import 'package:wherehome/features/home_insertion/widgets/switch_buttons_rent_type.dart';
import 'package:wherehome/features/home_insertion/widgets/switch_buttons_room_number.dart';

class InsertHome extends StatefulWidget {
  const InsertHome({super.key});

  @override
  State<InsertHome> createState() => _InsertHomeState();
}

class _InsertHomeState extends State<InsertHome> {
  late final TextEditingController priceInputController;
  late final TextEditingController areaInputController;
  late final TextEditingController tittleInputController;

  @override
  void initState() {
    priceInputController = TextEditingController();
    areaInputController = TextEditingController();
    tittleInputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    priceInputController.dispose();
    areaInputController = TextEditingController();
    tittleInputController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add_home').tr(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            'add_button_add'.tr(),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).colorScheme.tertiary,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'add_title'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextField(
                      controller: tittleInputController,
                      decoration: const InputDecoration(
                        hintText: 'Enter the tittle',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SwitchHomeType(),
                  ],
                ),
                const SizedBox(height: 16),
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
                    SwitchPropertyType()
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
                    const SwitchButtonsRooms()
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
                    const FilterFeatures(),
                  ],
                ),
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
                    const SearchBar(),
                    SizedBox(
                      height: 300,
                      width: double.maxFinite,
                      child: MapWidget(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
