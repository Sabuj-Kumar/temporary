import 'package:flutter/material.dart';
import 'package:google_map/EmployeeVarification/SalaryInput.dart';
import 'package:google_map/Map/google_map.dart';
import 'package:location/location.dart';

class Entry extends StatefulWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  Location location = Location();
  LocationData? _currentPosition;
  double? v1;
  double? v2;
  getLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _currentPosition = await location.getLocation();
    v1 = _currentPosition?.latitude;
    v2 = _currentPosition?.longitude;

    print("Location ${_currentPosition?.latitude}");
    print("Location ${_currentPosition?.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 300.0,
            ),
            Center(
              child: SizedBox(
                child: ElevatedButton(
                    onPressed: () async {
                      await getLocationPermission();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => GooggleMap(
                                    latitude: v1,
                                    longitude: v2,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shadowColor: Colors.white70,
                        side: const BorderSide(
                            color: Colors.black, style: BorderStyle.solid),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10)),
                    child: const Text(
                      "See your Location.",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
              ),
            ),
            Center(
              child: SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => SalaryInput()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shadowColor: Colors.white70,
                        side: const BorderSide(
                            color: Colors.black, style: BorderStyle.solid),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10)),
                    child: const Text(
                      "See Employee Location.",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
