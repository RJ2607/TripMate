import 'package:tripmate/models/google%20cloud%20models/maps/placeModel.dart';

class LodgingModel {
  String? activityName;
  String? note;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  bool? isCheckOut;
  PlaceDetailsModel? placeDetailsModel;
  String? category = 'Lodging';
  DateTime? date;

  LodgingModel({
    this.activityName,
    this.note,
    this.checkInTime,
    this.checkOutTime,
    this.isCheckOut,
    this.placeDetailsModel,
    this.date,
  });

  LodgingModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    note = json['note'];
    checkInTime = json['checkInTime'];
    checkOutTime = json['checkOutTime'];
    isCheckOut = json['isCheckOut'];
    placeDetailsModel = json['placeDetailsModel'] != null
        ? PlaceDetailsModel.fromJson(json['placeDetailsModel'])
        : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['note'] = note;
    data['checkInTime'] = checkInTime;
    data['checkOutTime'] = checkOutTime;
    data['isCheckOut'] = isCheckOut;
    data['placeDetailsModel'] = placeDetailsModel!.toJson();
    data['date'] = date;
    data['category'] = category;
    return data;
  }
}
