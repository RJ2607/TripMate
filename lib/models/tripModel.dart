import 'package:tripmate/models/activityModel.dart';

class TripModel {
  String id;
  String travelMode;
  String destination;
  DateTime startDate;
  DateTime endDate;
  bool isGroup;
  List<String>? invitees;
  List<ActivityModel>? activity;

  TripModel({
    required this.id,
    required this.travelMode,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.isGroup,
    this.invitees,
    this.activity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'travelMode': travelMode,
      'destination': destination,
      'startDate': startDate,
      'endDate': endDate,
      'isGroup': isGroup,
      'invitees': invitees,
      'activity': activity,
    };
  }

  factory TripModel.fromJson(Map<String, dynamic> data) {
    return TripModel(
      id: data['id'],
      travelMode: data['travelMode'],
      destination: data['destination'],
      startDate: data['startDate'].toDate(),
      endDate: data['endDate'].toDate(),
      isGroup: data['isGroup'],
      invitees: data['invitees'] != null
          ? List<String>.from(data['invitees'].map((x) => x))
          : null,
      activity: data['activity'] != null
          ? List<ActivityModel>.from(data['activity'].map((x) => x))
          : null,
    );
  }

  TripModel copyWith({
    String? id,
    String? travelMode,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    bool? isGroup,
    List<String>? invitees,
    List<ActivityModel>? activity,
  }) {
    return TripModel(
      id: id ?? this.id,
      travelMode: travelMode ?? this.travelMode,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isGroup: isGroup ?? this.isGroup,
      invitees: invitees ?? this.invitees,
      activity: activity ?? this.activity,
    );
  }
}
