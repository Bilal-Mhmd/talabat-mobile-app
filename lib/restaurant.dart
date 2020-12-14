class Restaurant {
  int id;
  String name;
  String city;
  int rating;
  String image;
  double weight;

  Restaurant({this.name, this.city, this.rating, this.image, this.id});
  factory Restaurant.fromJson(dynamic jsonObject) {
    return Restaurant(
      name: jsonObject['name'] as String,
      city: jsonObject['city'] as String,
      rating: jsonObject['rating'] as int,
      image: 'http://appback.ppu.edu/static/${jsonObject['image']}',
      id: jsonObject['id'] as int,
    );
  }
}
