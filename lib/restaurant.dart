class Restaurant {
  int id;
  String restaurantName;
  String city;
  int rating;
  String image;

  Restaurant(
      {this.restaurantName, this.city, this.rating, this.image, this.id});
  factory Restaurant.fromJson(dynamic json) {
    return Restaurant(
      restaurantName: json['name'] as String,
      city: json['city'] as String,
      rating: json['rating'] as int,
      image: json['image'] as String,
      id: json['id'] as int,
    );
  }
}
