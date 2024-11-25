import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:location/location.dart';

class MapsPage extends StatefulWidget {
  Map<String, dynamic> data;

  MapsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  StreamSubscription<LocationData>? _locationSubscription;
  LatLng? _currentP;
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    // _initializeMap();
  }

  @override
  void dispose() {
    // Cancel the location subscription to avoid memory leaks
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initializeMap() async {
    await getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      floatingActionButton: SpeedDial(
        icon: Clarity.map_outline_badged,
        activeIcon: Icons.close,
        animationDuration: const Duration(milliseconds: 500),
        children: [
          SpeedDialChild(
            child: Icon(IonIcons.location),
            label: "Current Location",
            onTap: () async {
              await getLocationUpdates();
              if (_currentP != null) await _cameraToPosition(_currentP!);
            },
          ),
          SpeedDialChild(
              child: Icon(IonIcons.arrow_redo),
              label: "Direction",
              onTap: () async {
                if (_currentP != null) {
                  List<LatLng> coordinates = await getPolylinePoints();
                  generatePolyLineFromPoints(coordinates);
                  _moveCameraToFitBounds();
                }
              }),
        ],
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) =>
            _mapController.complete(controller),
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.data['lat'], widget.data['lng']),
          zoom: 13,
        ),
        markers: {
          if (_currentP != null)
            Marker(
              markerId: const MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              infoWindow: InfoWindow(title: "Current Location"),
              position: _currentP!,
            ),
          Marker(
            markerId: const MarkerId("_sourceLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(widget.data['lat'], widget.data['lng']),
          ),
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  Future<void> _moveCameraToFitBounds() async {
    if (_currentP == null) return;
    final GoogleMapController controller = await _mapController.future;

    // Calculate bounds for the two points
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        widget.data['lat'] < _currentP!.latitude
            ? widget.data['lat']
            : _currentP!.latitude,
        widget.data['lng'] < _currentP!.longitude
            ? widget.data['lng']
            : _currentP!.longitude,
      ),
      northeast: LatLng(
        widget.data['lat'] > _currentP!.latitude
            ? widget.data['lat']
            : _currentP!.latitude,
        widget.data['lng'] > _currentP!.longitude
            ? widget.data['lng']
            : _currentP!.longitude,
      ),
    );

    // Move camera to fit bounds
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);
    controller.animateCamera(cameraUpdate);
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted =
        await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    _locationSubscription?.cancel();

    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        LatLng newLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        if (_currentP != newLocation && mounted) {
          // Ensure widget is mounted
          setState(() {
            _currentP = newLocation;
          });
        }
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: dotenv.env['GOOGLE_CLOUD_KEY']!,
        request: PolylineRequest(
          destination: PointLatLng(widget.data['lat'], widget.data['lng']),
          origin: PointLatLng(_currentP!.latitude, _currentP!.longitude),
          mode: TravelMode.driving,
        ),
      );

      if (result.points.isNotEmpty) {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      } else {
        print("Polyline API error: ${result.errorMessage}");
      }
    } catch (e) {
      print("Error fetching polyline points: $e");
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      color: Theme.of(context).primaryColor,
      points: polylineCoordinates,
      width: 5,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
