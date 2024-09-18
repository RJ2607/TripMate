class ActivityModel {
  String activityName;
  String location;
  String transport;
  String description;
  DateTime totalTime;

  ActivityModel({
    required this.activityName,
    required this.location,
    required this.transport,
    required this.description,
    required this.totalTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'activityName': activityName,
      'location': location,
      'transport': transport,
      'description': description,
      'totalTime': totalTime,
    };
  }

  factory ActivityModel.fromJson(Map<String, dynamic> data) {
    return ActivityModel(
      activityName: data['activityName'],
      location: data['location'],
      transport: data['transport'],
      description: data['description'],
      totalTime: data['totalTime'].toDate(),
    );
  }

  ActivityModel copyWith({
    String? activityName,
    String? location,
    String? transport,
    String? description,
    DateTime? totalTime,
  
  }) {
    return ActivityModel(
      activityName: activityName ?? this.activityName,
      location: location ?? this.location,
      transport: transport ?? this.transport,
      description: description ?? this.description,
      totalTime: totalTime ?? this.totalTime,
    );
  }
}
