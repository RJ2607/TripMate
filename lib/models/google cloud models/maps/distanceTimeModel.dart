class DistanceTimeModel {
  List<String> destinationAddresses;
  List<String> originAddresses;
  List<Row> rows;
  String status;

  DistanceTimeModel({
    required this.destinationAddresses,
    required this.originAddresses,
    required this.rows,
    required this.status,
  });

  factory DistanceTimeModel.fromJson(Map<String, dynamic> json) {
    return DistanceTimeModel(
      destinationAddresses: json['destination_addresses'] != null
          ? new List<String>.from(json['destination_addresses'])
          : [],
      originAddresses: json['origin_addresses'] != null
          ? new List<String>.from(json['origin_addresses'])
          : [],
      rows: json['rows'] != null
          ? (json['rows'] as List).map((i) => Row.fromJson(i)).toList()
          : [],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination_addresses'] = this.destinationAddresses;
    data['origin_addresses'] = this.originAddresses;
    data['status'] = this.status;
    data['rows'] = this.rows.map((v) => v.toJson()).toList();
    return data;
  }
}

class Row {
  List<Element> elements;

  Row({
    required this.elements,
  });

  factory Row.fromJson(Map<String, dynamic> json) {
    return Row(
      elements: json['elements'] != null
          ? (json['elements'] as List).map((i) => Element.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['elements'] = this.elements.map((v) => v.toJson()).toList();
    return data;
  }
}

class Element {
  Distance distance;
  Distance duration;
  String status;

  Element({
    required this.distance,
    required this.duration,
    required this.status,
  });

  factory Element.fromJson(Map<String, dynamic> json) {
    return Element(
      distance: Distance(
        text: json['distance']['text'],
        value: json['distance']['value'],
      ),
      duration: Distance(
        text: json['duration']['text'],
        value: json['duration']['value'],
      ),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance.toJson();
    data['duration'] = this.duration.toJson();
    data['status'] = this.status;
    return data;
  }
}

class Distance {
  String text;
  int value;

  Distance({
    required this.text,
    required this.value,
  });

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      text: json['text'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    return data;
  }
}
