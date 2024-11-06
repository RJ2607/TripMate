class SightseeingModel {
  String? activityName;
  String? note;
  DateTime? departureTime;
  DateTime? arrivalTime;
  String? placeName;
  String? location;
  String? category = 'Sightseeing';
  DateTime? date;

  SightseeingModel({
    this.activityName,
    this.note,
    this.departureTime,
    this.arrivalTime,
    this.placeName,
    this.location,
    this.date,
  });

  SightseeingModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    note = json['note'];
    departureTime = json['departureTime'];
    arrivalTime = json['arrivalTime'];
    placeName = json['placeName'];
    location = json['location'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['note'] = note;
    data['departureTime'] = departureTime;
    data['arrivalTime'] = arrivalTime;
    data['placeName'] = placeName;
    data['location'] = location;
    data['date'] = date;
    data['category'] = category;
    return data;
  }
}
