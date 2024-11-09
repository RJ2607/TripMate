class PlaceDetailsModel {
  String? name;
  String? address;
  String? photoRef;
  double? rating;
  int? userRatingCount;
  String? placeId;
  double? lat;
  double? lng;

  PlaceDetailsModel(
      {this.name,
      this.address,
      this.photoRef,
      this.rating,
      this.userRatingCount,
      this.placeId,
      this.lat,
      this.lng});

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
        name: json['name'],
        address: json['vicinity'],
        photoRef: json['photos'] != null
            ? json['photos'][0]['photo_reference']
            : null,
        rating: json['rating'] != null ? json['rating'].toDouble() : null,
        userRatingCount: json['user_ratings_total'],
        placeId: json['place_id'],
        lat: json['geometry']['location']['lat'],
        lng: json['geometry']['location']['lng']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'photoRef': photoRef,
      'rating': rating,
      'userRatingCount': userRatingCount,
      'placeId': placeId,
      'lat': lat,
      'lng': lng
    };
  }
}
