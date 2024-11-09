import '../google cloud models/maps/placeModel.dart';

class RestaurantModel {
  String? activityName;
  String? note;
  DateTime? reservationTime;
  PlaceDetailsModel? placeDetailsModel;
  String? category = 'Restaurant';
  DateTime? date;

  RestaurantModel({
    this.activityName,
    this.note,
    this.reservationTime,
    this.placeDetailsModel,
    this.date,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    note = json['note'];
    reservationTime = json['reservationTime'];
    placeDetailsModel = json['placeDetailsModel'] != null
        ? PlaceDetailsModel.fromJson(json['placeDetailsModel'])
        : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['note'] = note;
    data['reservationTime'] = reservationTime;
    data['placeDetailsModel'] = placeDetailsModel!.toJson();
    data['date'] = date;
    data['category'] = category;
    return data;
  }
}
