import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

LocationProvider locationProvider = LocationProvider();

class LocationProvider extends ChangeNotifier {
  String? _latlong;
  String? _location;
  String? get location => _location;
  String? get latlong => _latlong;

  Future checkPermissionsAndGetLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark placemark = placemarks[0];
    _latlong = '${position.latitude},${position.longitude}';
    _location =
        '${placemark.name!}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea} ${placemark.country} , ${placemark.postalCode}';

    log("_latlong$_latlong");
    log("_location$_location");

    notifyListeners();
  }

  void clear() {
    _latlong = null;
    _location = null;
    notifyListeners();
  }
}
