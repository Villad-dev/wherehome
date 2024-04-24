import 'package:flutter/material.dart';
import 'package:wherehome/common/widgets/home_item.dart';

class HomesList extends StatefulWidget {
  final List<String> homes = [
    'Home 1',
    'Home 2',
    'Home 3',
  ];

  HomesList({super.key});

  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <HomeItem>[],
    );
  }

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
