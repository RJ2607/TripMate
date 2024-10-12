class SightseeingModel {
  String? activityName;
  String? note;
  String? departureTime;
  String? arrivalTime;
  String? placeName;
  String? location;

  SightseeingModel({
    this.activityName,
    this.note,
    this.departureTime,
    this.arrivalTime,
    this.placeName,
    this.location,
  });

  SightseeingModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    note = json['note'];
    departureTime = json['departureTime'];
    arrivalTime = json['arrivalTime'];
    placeName = json['placeName'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['note'] = note;
    data['departureTime'] = departureTime;
    data['arrivalTime'] = arrivalTime;
    data['placeName'] = placeName;
    data['location'] = location;
    return data;
  }
}
