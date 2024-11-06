class LodgingModel {
  String? activityName;
  String? note;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  bool? isCheckOut;
  String? accommodationName;
  String? location;
  String? category = 'Lodging';
  DateTime? date;

  LodgingModel({
    this.activityName,
    this.note,
    this.checkInTime,
    this.checkOutTime,
    this.isCheckOut,
    this.accommodationName,
    this.location,
    this.date,
  });

  LodgingModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    note = json['note'];
    checkInTime = json['checkInTime'];
    checkOutTime = json['checkOutTime'];
    isCheckOut = json['isCheckOut'];
    accommodationName = json['accommodationName'];
    location = json['location'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['note'] = note;
    data['checkInTime'] = checkInTime;
    data['checkOutTime'] = checkOutTime;
    data['isCheckOut'] = isCheckOut;
    data['accommodationName'] = accommodationName;
    data['location'] = location;
    data['date'] = date;
    data['category'] = category;
    return data;
  }
}
