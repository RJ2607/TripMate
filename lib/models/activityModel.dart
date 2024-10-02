class ActivityModel {
  String activityName;
  String category;
  String description;
  DateTime totalTime;

  ActivityModel({
    required this.activityName,
    required this.category,
    required this.description,
    required this.totalTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'activityName': activityName,
      'category': category,
      'description': description,
      'totalTime': totalTime,
    };
  }

  factory ActivityModel.fromJson(Map<String, dynamic> data) {
    return ActivityModel(
      activityName: data['activityName'],
      category: data['category'],
      description: data['description'],
      totalTime: data['totalTime'].toDate(),
    );
  }

  ActivityModel copyWith({
    String? activityName,
    String? category,
    String? transport,
    String? description,
    DateTime? totalTime,
  }) {
    return ActivityModel(
      activityName: activityName ?? this.activityName,
      category: category ?? this.category,
      description: description ?? this.description,
      totalTime: totalTime ?? this.totalTime,
    );
  }
}
