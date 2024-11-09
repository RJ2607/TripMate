import '../google cloud models/maps/placeModel.dart';

class SightseeingModel {
  String? activityName;
  String? note;
  DateTime? departureTime;
  DateTime? arrivalTime;
  PlaceDetailsModel? placeDetailsModel;
  String? category = 'Sightseeing';
  DateTime? date;

  SightseeingModel({
    this.activityName,
    this.note,
    this.departureTime,
    this.arrivalTime,
    this.placeDetailsModel,
    this.date,
  });

  SightseeingModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    note = json['note'];
    departureTime = json['departureTime'];
    arrivalTime = json['arrivalTime'];
    placeDetailsModel = json['placeDetailsModel'] != null
        ? PlaceDetailsModel.fromJson(json['placeDetailsModel'])
        : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['note'] = note;
    data['departureTime'] = departureTime;
    data['arrivalTime'] = arrivalTime;
    data['placeDetailsModel'] = placeDetailsModel!.toJson();
    data['date'] = date;
    data['category'] = category;
    return data;
  }
}
