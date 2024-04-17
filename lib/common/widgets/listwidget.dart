import 'package:flutter/material.dart';
import 'package:wherehome/HomeItem.dart';

class HomesList extends StatefulWidget{
     final List<String> homes = [
       'Home 1',
       'Home 2',
       'Home 3',
     ];

     @override
     Widget build(BuildContext context) {
       return CustomScrollView(
         slivers: <HomeItem>[

         ],
       );
     }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }


}