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
        title: const Text('Insert Home'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            'Add home',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
                    const Text(
                      'Tittle',
                      style: TextStyle(
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
                        const Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: priceInputController,
                            decoration: const InputDecoration(
                              hintText: 'Enter the price',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Area',
                          style: TextStyle(
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Property type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SwitchPropertyType()
                  ],
                ),
                const SizedBox(height: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rooms',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SwitchButtonsRooms()
                  ],
                ),
                const SizedBox(height: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FilterFeatures(),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(
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
