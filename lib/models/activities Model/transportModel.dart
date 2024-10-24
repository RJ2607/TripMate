class TransportModel {
  String? activityName;
  String? note;
  String? travelMode;
  String? departureTime;
  String? arrivalTime;
  String? departureLocation;
  String? arrivalLocation;
  String? category = 'Transport';
  DateTime? date;

  TransportModel({
    this.activityName,
    this.note,
    this.travelMode,
    this.departureTime,
    this.arrivalTime,
    this.departureLocation,
    this.arrivalLocation,
    this.date,
  });

  TransportModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    note = json['note'];
    travelMode = json['travelMode'];
    departureTime = json['departureTime'];
    arrivalTime = json['arrivalTime'];
    departureLocation = json['departureLocation'];
    arrivalLocation = json['arrivalLocation'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['note'] = note;
    data['travelMode'] = travelMode;
    data['departureTime'] = departureTime;
    data['arrivalTime'] = arrivalTime;
    data['departureLocation'] = departureLocation;
    data['arrivalLocation'] = arrivalLocation;
    data['date'] = date;
    data['category'] = category;
    return data;
  }
}
