import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/custom_grid_delegate.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(12.0),
      gridDelegate: CustomGridDelegate(dimension: 80.0),
      itemBuilder: (BuildContext context, int index) {
        final math.Random random = math.Random(index);
        return GridTile(
          header: GridTileBar(
            title: Text('$index', style: const TextStyle(color: Colors.black)),
          ),
          child: Container(
            margin: const EdgeInsets.all(3.0),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              gradient: const RadialGradient(
                colors: <Color>[Color(0x001f51c0), Color(0x2F0099BB)],
              ),
            ),
            child: FlutterLogo(
              style: FlutterLogoStyle
                  .values[random.nextInt(FlutterLogoStyle.values.length)],
            ),
          ),
        );
      },
    );
  }
}
