import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GooggleMap extends StatefulWidget {
  const GooggleMap({Key? key, required this.latitude, required this.longitude})
      : super(key: key);
  final double? latitude;
  final double? longitude;
  @override
  _GooggleMapState createState() => _GooggleMapState();
}

class _GooggleMapState extends State<GooggleMap> {
  late LatLng? _initialcameraposition;
  @override
  void initState() {
    _initialcameraposition =
        LatLng(widget.longitude ?? 0.0, widget.latitude ?? 0.0);
    super.initState();
  }

  late GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    try {
      _controller = _cntlr;
      _location.onLocationChanged.listen((l) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
          ),
        );
      });
    } catch (e) {
      throw "not Connected";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            if (_initialcameraposition != null)
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initialcameraposition!),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
              ),
          ],
        ),
      ),
    );
  }
}
