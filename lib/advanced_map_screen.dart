import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class AdvancedMapScreen extends StatefulWidget {
  const AdvancedMapScreen({Key? key}) : super(key: key);

  @override
  _AdvancedMapScreenState createState() => _AdvancedMapScreenState();
}

class _AdvancedMapScreenState extends State<AdvancedMapScreen> {
  late GoogleMapController mapController;
  double compassHeading = 0;
  LatLng? selectedMarkerPosition;
  Set<Marker> markers = {};

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

  void _onMapLongPress(LatLng position) {
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: const InfoWindow(title: 'Custom Marker'),
        ),
      );
    });
  }

  void _navigateToMarker() {
    if (selectedMarkerPosition != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(selectedMarkerPosition!),
      );
    }
  }

  void _recenterMap() async {
    final userLocation = await getCurrentUserLocation();
    if (userLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(userLocation),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Maps Example'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            onLongPress: _onMapLongPress,
            zoomControlsEnabled: true, // Disable default zoom controls
            compassEnabled: true, // Disable compass
            myLocationEnabled: true, // Enable my location button
            myLocationButtonEnabled: false, // Hide default my location button
            padding: const EdgeInsets.only(
              bottom: 70,
              right: 15,
            ), // Adjust padding to move zoom buttons up
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Compass Heading: ${compassHeading.toStringAsFixed(2)}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  if (selectedMarkerPosition != null) ...[
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _navigateToMarker,
                      child: const Text('Navigate to Marker'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recenterMap,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}

Future<LatLng?> getCurrentUserLocation() async {
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  try {
    final Position position = await geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  } catch (e) {
    print("Error getting user location: $e");
    return null;
  }
}
