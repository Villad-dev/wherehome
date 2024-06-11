import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wherehome/features/favourite_home/favourite_view.dart';
import 'package:wherehome/features/map_search/map_view.dart';
import 'package:wherehome/features/profile/profile_view.dart';

import '../../data/models/filter.dart';
import '../../data/models/home.dart';
import '../home_details/homedetails_view.dart';
import 'widgets/toggle_buttons.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required String title});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isGrid = true;

  void toggleToGrid() {
    setState(() {
      isGrid = true;
    });
  }

  void toggleToList() {
    setState(() {
      isGrid = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhereHome'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement search functionality
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ToggleButtonsExample(
                  isGrid: isGrid,
                  onToggleGrid: toggleToGrid,
                  onToggleList: toggleToList,
                ),
                const FiltersWidget(),
              ],
            ),
          ),
          Expanded(
            child: HomesGrid(isGrid: isGrid),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home/insert_new_home');
        },
        elevation: 3, // Add elevation for a shadow effect
        tooltip: 'Add home',
        child: const Icon(
            Icons.add), // Tooltip text when the button is long-pressed
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                // TODO: Implement catalog functionality
              },
              icon: const Icon(Icons.menu),
            ),
            IconButton(
              onPressed: () {
                // TODO: Implement favorite functionality
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteView()));
              },
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {
                // TODO: Implement map functionality
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MapView()));
              },
              icon: const Icon(Icons.map),
            ),
            IconButton(
              onPressed: () {
                // TODO: Implement profile functionality
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileView()));
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

class HomesGrid extends StatelessWidget {
  final bool isGrid;

  const HomesGrid({super.key, required this.isGrid});

  static List<Home> homes = [
    Home('ul. Piotrokowska', '2', 'Warsaw', 4000.0, 45.0, 2,
        "assets/images/img2.jpg"),
    Home(
        'ul. Bohaterska', '5', 'Warsaw', 2450, 45, 2, "assets/images/img2.jpg"),
    Home('ul. Kaminskiego', '40', 'Poznan', 4650, 45, 2,
        "assets/images/img1.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return isGrid
        ? GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.75, // Adjust this to change the item size
            ),
            itemCount: HomesGrid.homes.length,
            itemBuilder: (BuildContext context, int index) {
              return HomeWidget(
                homeDataSet: HomesGrid.homes[index],
                elementHeight: 250,
                imageHeight: 100,
              );
            },
          )
        : ListView(
            padding: const EdgeInsets.all(10.0),
            children: HomesGrid.homes.map((home) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: HomeWidget(
                  homeDataSet: home,
                  elementHeight: 350,
                  imageHeight: 200,
                ),
              );
            }).toList(),
          );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            onTap: () {
              controller.openView();
            },
            leading: const Icon(Icons.search),
            hintText: 'find_home'.tr(),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2,
              minWidth: 100,
              minHeight: 50,
              maxHeight: 100,
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              },
            );
          });
        },
      ),
    );
  }
}

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({super.key});

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  Filter? selectedFilter;
  List<DropdownMenuEntry<Filter>> filters = [
    DropdownMenuEntry(value: Filter('promotion ASC'), label: 'asc_price'.tr()),
    DropdownMenuEntry(
        value: Filter('promotion DESC'), label: 'desc_price'.tr()),
    DropdownMenuEntry(
        value: Filter('date of publishing ASC'), label: 'asc_area'.tr()),
    DropdownMenuEntry(
        value: Filter('date of publishing DESC'), label: 'desc_area'.tr()),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DropdownButton<Filter>(
      value: selectedFilter,
      hint: Text(
        'sorting_type'.tr(),
        style: const TextStyle(color: Colors.black),
      ),
      icon: Icon(
        Icons.arrow_downward,
        color: colorScheme.tertiary,
      ),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: colorScheme.surface,
      ),
      onChanged: (Filter? newValue) {
        setState(() {
          selectedFilter = newValue!;
        });
      },
      items: filters.map((DropdownMenuEntry entry) {
        return DropdownMenuItem<Filter>(
          value: entry.value,
          child: Text(entry.label, style: const TextStyle(color: Colors.black)),
        );
      }).toList(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final Home homeDataSet;
  final int elementHeight;
  final int imageHeight;

  const HomeWidget({
    super.key,
    required this.homeDataSet,
    required this.elementHeight,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeItemView(
                homeDetails: homeDataSet,
              ),
            ));
      },
      child: Container(
        height: elementHeight.toDouble(),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            width: 1.0,
            color: Colors.white30,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: imageHeight.toDouble(),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.asset(
                  homeDataSet.imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Property name",
                        textAlign: TextAlign.center, // Align text to center
                      ),
                    ],
                  ),
                  Text(
                    '${homeDataSet.price} ${tr('currency')}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ), // Align text to center
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Text(
                        "${homeDataSet.address} ${homeDataSet.addressNum}",
                        textAlign: TextAlign.center, // Align text to center
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HomeProperty(
                        icon: Icons.bed_rounded,
                        measure: Text('5 '),
                      ),
                      const HomeProperty(
                        icon: Icons.bathtub_outlined,
                        measure: Text('2 '),
                      ),
                      const HomeProperty(
                        icon: Icons.kitchen_rounded,
                        measure: Text('2 '),
                      ),
                      HomeProperty(
                          icon: Icons.grid_3x3_rounded,
                          measure: RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: '45',
                                  style: TextStyle(color: Colors.black87)),
                              const TextSpan(
                                  text: 'm',
                                  style: TextStyle(color: Colors.black87)),
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(1, -5),
                                  child: const Text(
                                    '2',
                                    textScaler: TextScaler.linear(0.7),
                                  ),
                                ),
                              ),
                            ]),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeProperty extends StatelessWidget {
  const HomeProperty({super.key, required this.icon, required this.measure});

  final Widget measure;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(icon), measure],
    );
  }
}
