import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_compass/flutter_compass.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  double compassHeading = 0;

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _initCompass();
  }

  void _initCompass() {
    FlutterCompass.events?.listen((event) {
      setState(() {
        compassHeading = event.heading ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Example'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: initialCameraPosition,
            markers: {
              const Marker(
                markerId: MarkerId('marker_1'),
                position: LatLng(37.7749, -122.4194),
                infoWindow: InfoWindow(title: 'Marker Title'),
              ),
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Compass Heading: ${compassHeading.toStringAsFixed(2)}°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
