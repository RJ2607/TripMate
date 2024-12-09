import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tripmate/models/google%20cloud%20models/maps/placeModel.dart';
import 'package:tripmate/models/google%20cloud%20models/maps/placePredictionModel.dart';

import '../../models/google cloud models/maps/distanceTimeModel.dart';

class GoogleCloudMapController {
  String googleCloudKey = dotenv.env['GOOGLE_CLOUD_KEY']!;
  String googleMapUrl = 'maps.googleapis.com';

  Rx<DistanceTimeModel> distanceTimeModel = DistanceTimeModel(
          destinationAddresses: [],
          originAddresses: [],
          rows: [],
          status: 'Failed to fetch distance and time')
      .obs;

  Future<PlacePredictionModel> getAutoCompletePlaces(String input) async {
    try {
      Map<String, String> query = {
        "input": input, // Use the input parameter dynamically
        "key": googleCloudKey,
      };
      Uri url =
          Uri.https(googleMapUrl, "/maps/api/place/autocomplete/json", query);
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'OK') {
          final result = PlacePredictionModel.fromJson(jsonResponse);
          return result;
        }
      } else {
        log("Failed to fetch places. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Exception occurred: $e");
    }
    return PlacePredictionModel(predictions: [], status: '');
  }

  Future<PlaceDetailsModel> getPlaceDetails(String placeId) async {
    try {
      Map<String, String> query = {
        "place_id": placeId,
        "key": googleCloudKey,
      };
      Uri url = Uri.https(googleMapUrl, "/maps/api/place/details/json", query);
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'OK') {
          final result = PlaceDetailsModel(
              address: jsonResponse['result']['formatted_address'],
              name: jsonResponse['result']['name'],
              placeId: jsonResponse['result']['place_id'],
              rating: jsonResponse['result']['rating'].toDouble(),
              userRatingCount: jsonResponse['result']['user_ratings_total'],
              lat: jsonResponse['result']['geometry']['location']['lat'],
              lng: jsonResponse['result']['geometry']['location']['lng'],
              photoRef: jsonResponse['result']['photos'] != null
                  ? jsonResponse['result']['photos'][0]['photo_reference']
                  : null);

          return result;
        }
      } else {
        log("Failed to fetch places. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Exception occurred: $e");
    }
    return PlaceDetailsModel();
  }

  Future getPlacePhoto(
    String photoReference,
    int maxWidth,
    int maxHeight,
  ) async {
    try {
      Map<String, String> query = {
        "maxwidth": maxWidth.toString(),
        "maxheight": maxHeight.toString(),
        "photoreference": photoReference,
        "key": googleCloudKey,
      };
      Uri url = Uri.https(googleMapUrl, "/maps/api/place/photo", query);
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        Get.snackbar('Error', 'Failed to fetch image');
        log("Failed to fetch places. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Exception occurred: $e");
    }
  }

  Future<void> getDistanceTime(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  ) async {
    try {
      Map<String, String> query = {
        "origins": "$originLat,$originLng",
        "destinations": "$destinationLat,$destinationLng",
        "key": googleCloudKey,
      };
      Uri url = Uri.https(googleMapUrl, "/maps/api/distancematrix/json", query);
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'OK') {
          final result = DistanceTimeModel.fromJson(jsonResponse);
          distanceTimeModel.value = result;
        }
      } else {
        log("Failed to fetch distance and time. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Exception occurred: $e");
    }
  }
}
