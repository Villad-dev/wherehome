import 'dart:core';

import 'package:flutter/material.dart';
import 'package:wherehome/features/favourite_home/favourite_view.dart';
import 'package:wherehome/features/map_search/map_view.dart';
import 'package:wherehome/features/profile/profile_view.dart';

import '../../data/models/filter.dart';
import '../../data/models/home.dart';
import 'widgets/homeitem_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hola'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement search functionality
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchWidget(),
          SizedBox(height: 8),
          FiltersWidget(),
          Expanded(
            child: HomesGrid(),
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
  const HomesGrid({super.key});

  static List<Home> homes = [
    Home('ul. Piotrokowska', '2', 'Warsaw', 4000.0, 45.0, 2,
        "assets/images/img2.jpg"),
    Home(
        'ul. Bohaterska', '5', 'Warsaw', 2450, 45, 2, "assets/images/img2.jpg"),
    Home('ul. Kaminskiego', '40', 'Poznan', 4650, 45, 2,
        "assets/images/img1.jpg"),
    // Add more homes as needed
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(10.0),
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: homes.map((home) {
        return HomeWidget(
          homeDataSet: home,
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
            hintText: 'Find home',
            constraints: const BoxConstraints(
              maxWidth: 400,
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
  List<DropdownMenuEntry<Filter>> filters = [
    DropdownMenuEntry(value: Filter('sorting'), label: 'sorting'),
    DropdownMenuEntry(value: Filter('promotion ASC'), label: 'promotion ASC'),
    DropdownMenuEntry(value: Filter('promotion DESC'), label: 'promotion DESC'),
    DropdownMenuEntry(
        value: Filter('date of publishing ASC'),
        label: 'date of publishing ASC'),
    DropdownMenuEntry(
        value: Filter('date of publishing DESC'),
        label: 'date of publishing DESC'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Sorting'),
          ),
          DropdownMenu(
              width: 200.0,
              label: const Text('label'),
              hintText: 'hint text',
              enableFilter: true,
              dropdownMenuEntries: filters)
        ],
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final Home homeDataSet;

  const HomeWidget({
    super.key,
    required this.homeDataSet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeItemView()));
      }, // Execute the callback function when tapped

      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
         /* border: Border.all(
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
          ],*/
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.asset(
                  homeDataSet.imagePath,
                ),
              ),
            ),
            Text(
              "${homeDataSet.address} ${homeDataSet.addressNum}",
              textAlign: TextAlign.center, // Align text to center
            ),
            Text(
              "${homeDataSet.price}  zl",
              textAlign: TextAlign.center, // Align text to center
            ),
          ],
        ),
      ),
    );
  }
}
