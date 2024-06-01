import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionhandler;

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  Location location = Location();
  late LocationData currentLocation;
  late final permissionhandler.Permission permission;
  permissionhandler.PermissionStatus permissionStatus =
      permissionhandler.PermissionStatus.denied;
  late MapboxMap mapboxMap;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    final status = await permissionhandler.Permission.location.request();
    setState(() {
      permissionStatus = status;
    });
  }

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('map_view').tr(),
      ),
      body: MapWidget(
        styleUri: 'mapbox://styles/villad/clvs1warh01wa01qu1rfcc9jh',
        mapOptions: MapOptions(
          pixelRatio: 2,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }

  Future<void> showCurrentLocation() async {
    try {
      final LocationData locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
      });
      mapboxMap.flyTo(
        CameraOptions(
          anchor: ScreenCoordinate(x: 0, y: 0),
          zoom: 17,
          bearing: 180,
          pitch: 30,
        ),
        MapAnimationOptions(
          duration: 1000,
          startDelay: 0,
        ),
      );
      //mapController.move(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), 15.0);
    } catch (e) {
      Exception('Failed to get current location: $e');
    }
  }
}
