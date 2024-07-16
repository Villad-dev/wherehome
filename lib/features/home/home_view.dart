import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/controllers/http_controller.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/providers/user_provider.dart';
import 'package:wherehome/common/widgets/dialog_error.dart';
import 'package:wherehome/data/repositories/home_owner_repo.dart';
import 'package:wherehome/data/repositories/home_repo.dart';
import 'package:wherehome/features/favourite_home/favourite_view.dart';
import 'package:wherehome/features/map_view/map_view.dart';
import 'package:wherehome/features/profile/profile_view.dart';
import 'package:wherehome/features/profile/widgets/empty_profile.dart';

import '../profile/widgets/homeowner_profile.dart';
import 'widgets/dropdown_filter.dart';
import 'widgets/home_resizable.dart';
import 'widgets/search_widget.dart';
import 'widgets/toggle_buttons.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  bool isGrid = true;
  List<Home> homes = [];

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
  void didChangeDependencies() {
    fetchHomes(null);
    super.didChangeDependencies();
  }

  void fetchHomes(String? query) {
    final api = HttpController(); //HttpControllerInherited.of(context).api;
    api.sendGetRequest(query != null ? 'homes?$query' : 'homes', null,
        (onSuccess) {
      final jsonResponse = jsonDecode(onSuccess.body) as List<dynamic>;
      final List<Home> fetchedHomes = Home.toListFromJson(jsonResponse);
      setState(() {
        homes = fetchedHomes;
      });
    }, (onFail) {
      showErrorDialog(context, onFail.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WhereHome',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchHomeWidget(
            onSearch: (String query) {
              setState(() {
                fetchHomes('search=$query');
              });
            },
          ),
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
                FiltersWidget(
                  onFilterApplied: (String filter) {
                    setState(() {
                      fetchHomes(filter);
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: HomesGrid(isGrid: isGrid, homes: homes),
          ),
        ],
      ),
      floatingActionButton: user.isUserAuthenticated
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).colorScheme.primary,
              splashColor: Theme.of(context).colorScheme.onSecondary,
              hoverColor: Theme.of(context).colorScheme.secondary,
              onPressed: () async {
                final result =
                    await Navigator.pushNamed(context, '/home/insert_new_home');
                if (result == 'home_added') {
                  fetchHomes(null);
                }
              },
              elevation: 3,
              tooltip: 'Add home',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomAppBar(
        elevation: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            IconButton(
              onPressed: () {
                loadWidgetAuthorized(context,
                    (owner) => FavoriteView(favoriteHomes: owner.favourite!));
              },
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapView(homes: homes),
                      ));
                },
                icon: const Icon(Icons.map)),
            IconButton(
              onPressed: () {
                loadWidgetAuthorized(
                    context,
                    (owner) =>
                        ProfileView(child: ProfileInfo(homeOwner: owner)));
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

void loadWidgetAuthorized(
    BuildContext context, Widget Function(HomeOwner) successWidget) {
  final api = HttpControllerInherited.of(context).api;
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  if (userProvider.homeOwner != null) {
    api.sendGetRequest('homeowner/${userProvider.homeOwner!.id}',
        {'Authorization': 'Bearer ${userProvider.apiToken}'}, (success) {
      final json = jsonDecode(success.body);
      HomeOwner? homeOwner = HomeOwner.fromJson(json);
      userProvider.setHomeOwner(homeOwner);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => successWidget(homeOwner)),
      );
    }, (failure) {
      showErrorDialog(context, 'You are not authorized');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileView(
            child: EmptyProfile(),
          ),
        ),
      );
    });
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileView(
          child: EmptyProfile(),
        ),
      ),
    );
  }
}

class HomesGrid extends StatelessWidget {
  final bool isGrid;
  final List<Home> homes;

  const HomesGrid({super.key, required this.isGrid, required this.homes});

  @override
  Widget build(BuildContext context) {
    const gridItemHeight = 300.0;
    return isGrid
        ? GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: gridItemHeight,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.62,
            ),
            itemCount: homes.length,
            itemBuilder: (BuildContext context, int index) {
              return HomeWidget(
                homeDataSet: homes[index],
                elementHeight: gridItemHeight.toInt(),
                imageHeight: 100,
              );
            },
          )
        : ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: homes.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: HomeWidget(
                  homeDataSet: homes[index],
                  elementHeight: 375,
                  imageHeight: 175,
                ),
              );
            },
          );
  }
}
