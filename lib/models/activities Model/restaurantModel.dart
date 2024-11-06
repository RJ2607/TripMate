class RestaurantModel {
  String? activityName;
  String? note;
  DateTime? reservationTime;
  String? accommodationName;
  String? location;
  String? category = 'Restaurant';
  DateTime? date;

  RestaurantModel({
    this.activityName,
    this.note,
    this.reservationTime,
    this.accommodationName,
    this.location,
    this.date,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    note = json['note'];
    reservationTime = json['reservationTime'];
    accommodationName = json['accommodationName'];
    location = json['location'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['note'] = note;
    data['reservationTime'] = reservationTime;
    data['accommodationName'] = accommodationName;
    data['location'] = location;
    data['date'] = date;
    data['category'] = category;
    return data;
  }
}
