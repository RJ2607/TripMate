import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required Completer<GoogleMapController> mapController,
    required this.data,
    required LatLng? currentP,
    required this.polylines,
    required this.mapStyleString,
  })  : _mapController = mapController,
        _currentP = currentP;

  final Completer<GoogleMapController> _mapController;
  final Map<String, dynamic> data;
  final LatLng? _currentP;
  final Map<PolylineId, Polyline> polylines;
  final String mapStyleString;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      indoorViewEnabled: true,
      trafficEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
        _mapController.future.then((value) {
          value.setMapStyle(mapStyleString);
        });
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(data['lat'], data['lng']),
        zoom: 15,
      ),
      markers: {
        if (_currentP != null)
          Marker(
            markerId: const MarkerId("_currentLocation"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(title: "Current Location"),
            position: _currentP,
          ),
        Marker(
          markerId: const MarkerId("_sourceLocation"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(data['lat'], data['lng']),
        ),
      },
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}
