import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tripmate/controller/google%20cloud%20controllers/googleMapContreller.dart';
import 'package:tripmate/views/Maps/widgets/map_widget.dart';

class MapsPage extends StatefulWidget {
  MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  StreamSubscription<LocationData>? _locationSubscription;
  GoogleCloudMapController _googleCloudMapController =
      Get.put(GoogleCloudMapController());
  LatLng? _currentP;
  Map<PolylineId, Polyline> polylines = {};
  bool _isPolylineGenerated = false;
  late String _mapStyleString;

  Map<String, dynamic> data = Get.arguments['data'];

  @override
  void initState() {
    super.initState();
    // data = Get.arguments['data'];
    _mapStyleString = '';
    _initializeMap();
    rootBundle.loadString('assets/maps_style/aubergine.json').then((string) {
      setState(() {
        _mapStyleString = string;
      });
    });
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
      floatingActionButton: FloatingActionButton(
          child: Icon(IonIcons.arrow_redo),
          onPressed: () async {
            log("Fetching polyline points");
            log("Current position: $_currentP");
            if (_currentP != null) {
              log("Current position: $_currentP");
              List<LatLng> polylineCoordinates = await getPolylinePoints();
              await generatePolyLineFromPoints(polylineCoordinates);
              _googleCloudMapController.getDistanceTime(_currentP!.latitude,
                  _currentP!.longitude, data['lat'], data['lng']);
            }
            log("Polyline generated");
          }),
      body: SafeArea(
        child: Stack(
          children: [
            if (_mapStyleString
                .isNotEmpty) // Only render when map style is loaded
              MapWidget(
                mapController: _mapController,
                data: data,
                currentP: _currentP,
                polylines: polylines,
                mapStyleString: _mapStyleString,
              )
            else
              Center(child: CircularProgressIndicator()),
            Positioned(
              left: 0,
              bottom: 0,
              child: _isPolylineGenerated
                  ? !_googleCloudMapController
                          .distanceTimeModel.value.rows.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  AntDesign.car_outline,
                                  size:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _googleCloudMapController
                                        .distanceTimeModel
                                        .value
                                        .rows[0]
                                        .elements[0]
                                        .duration
                                        .text,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Row(children: [
                                    Text(
                                      _googleCloudMapController
                                          .distanceTimeModel
                                          .value
                                          .rows[0]
                                          .elements[0]
                                          .distance
                                          .text,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("•"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateFormat.jm().format(DateTime.now().add(
                                          Duration(
                                              seconds: _googleCloudMapController
                                                  .distanceTimeModel
                                                  .value
                                                  .rows[0]
                                                  .elements[0]
                                                  .duration
                                                  .value))),
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ])
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                            ],
                          ))
                      : Shimmer(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.grey,
                              Colors.black,
                            ],
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _moveCameraToFitBounds() async {
    if (_currentP == null) return;
    final GoogleMapController controller = await _mapController.future;

    // Calculate bounds for the two points
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        data['lat'] < _currentP!.latitude ? data['lat'] : _currentP!.latitude,
        data['lng'] < _currentP!.longitude ? data['lng'] : _currentP!.longitude,
      ),
      northeast: LatLng(
        data['lat'] > _currentP!.latitude ? data['lat'] : _currentP!.latitude,
        data['lng'] > _currentP!.longitude ? data['lng'] : _currentP!.longitude,
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
          destination: PointLatLng(data['lat'], data['lng']),
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

  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      consumeTapEvents: true,
      onTap: () {
        log("Polyline tapped");
      },
      polylineId: id,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      color: Colors.blue,
      points: polylineCoordinates,
      jointType: JointType.round,
      width: 4,
    );
    setState(() {
      polylines[id] = polyline;
      _isPolylineGenerated = true;
    });
    await _moveCameraToFitBounds();
  }
}
