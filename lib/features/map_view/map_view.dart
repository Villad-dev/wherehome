import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionhandler;
import 'package:permission_handler/permission_handler.dart';
import 'package:wherehome/data/repositories/home_repo.dart';

class MapView extends StatefulWidget {
  final List<Home> homes;

  const MapView({required this.homes, super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  Location location = Location();
  late MapboxMap mapboxMap;
  late LocationData currentLocation;
  permissionhandler.PermissionStatus permissionStatus =
      permissionhandler.PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    requestPermission().then((_) {
      if (permissionStatus.isGranted) {
        showCurrentLocation();
      }
    });
  }

  Future<void> requestPermission() async {
    final status = await permissionhandler.Permission.location.request();
    setState(() {
      permissionStatus = status;
    });
    if (status.isGranted) {
      showCurrentLocation();
    }
  }

  void _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    if (permissionStatus.isGranted) {
      showCurrentLocation();
      showHomesOnMap();
    }
  }

  void showHomesOnMap() {
    mapboxMap.annotations.createPointAnnotationManager().then(
      (pointAnnotationManager) async {
        final ByteData bytes =
            await rootBundle.load('assets/images/custom-icon.png');
        final Uint8List list = bytes.buffer.asUint8List();
        var options = <PointAnnotationOptions>[];

        for (var home in widget.homes) {
          options.add(PointAnnotationOptions(
            geometry: Point(coordinates: Position(home.long, home.lat)),
            image: list,
          ));
        }

        pointAnnotationManager.createMulti(options);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('map_view').tr(),
      ),
      body: permissionStatus.isGranted
          ? MapWidget(
              styleUri: 'mapbox://styles/villad/clvs1warh01wa01qu1rfcc9jh',
              mapOptions: MapOptions(
                pixelRatio: 2,
              ),
              onMapCreated: _onMapCreated,
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Please grant location permission.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  OutlinedButton(
                      onPressed: () async {
                        await openAppSettings();
                      },
                      child: const Text('Go to Permission Settings'))
                ],
              ),
            ),
      floatingActionButton: permissionStatus.isGranted
          ? FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: showCurrentLocation,
              child: Icon(Icons.my_location_rounded,
                  color: Theme.of(context).cardColor),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Future<void> showCurrentLocation() async {
    try {
      final LocationData locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
      });
      final userLocation = Point(
          coordinates:
              Position(locationData.longitude!, locationData.latitude!));
      mapboxMap.flyTo(
        CameraOptions(
          center: userLocation,
          zoom: 6.0,
        ),
        MapAnimationOptions(
          duration: 1000,
        ),
      );
    } catch (e) {
      debugPrint('Failed to get current location: $e');
    }
  }
}
