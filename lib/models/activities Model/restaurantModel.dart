class RestaurantModel {
  String? activityName;
  String? note;
  String? reservationTime;
  String? accommodationName;
  String? location;

  RestaurantModel({
    this.activityName,
    this.note,
    this.reservationTime,
    this.accommodationName,
    this.location,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    note = json['note'];
    reservationTime = json['reservationTime'];
    accommodationName = json['accommodationName'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityName'] = activityName;
    data['note'] = note;
    data['reservationTime'] = reservationTime;
    data['accommodationName'] = accommodationName;
    data['location'] = location;
    return data;
  }
}
