import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  final LatLng _center = const LatLng(45.521563, -122.677433);
  String? errorMessage; // For storing error messages if any

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Sample App'),
        elevation: 2,
      ),
      body: errorMessage != null
          ? Center(
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              markers: {
                Marker(
                  markerId: MarkerId('1'),
                  position: _center,
                  infoWindow: const InfoWindow(
                    title: 'Portland',
                    snippet: 'Oregon',
                  ),
                ),
              },
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              onCameraMove: (position) {
                // Optional: Add camera movement handler if needed
              },

              // onMapError: (code, message) {
              //   setState(() {
              //     errorMessage = "Map Error ($code): $message";
              //   });
              // },
            ),
    );
  }
}
