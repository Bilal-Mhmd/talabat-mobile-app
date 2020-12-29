class Dish {
  String title;
  String description;
  double price;
  double rating;
  String image;
  int id;
  int rest_id;

  Dish(
      {this.title,
      this.description,
      this.price,
      this.image,
      this.rating,
      this.id,
      this.rest_id});

  factory Dish.fromJson(dynamic jsonObject) {
    return Dish(
        title: jsonObject['name'],
        description: jsonObject['descr'],
        price: double.parse(jsonObject['price'].toString()),
        image: 'http://appback.ppu.edu/static/${jsonObject['image']}',
        rating: jsonObject['rating'],
        id: jsonObject['id'],
        rest_id: jsonObject['rest_id']);
  }

  factory Dish.fromMap(Map<String, dynamic> data) {
    return Dish(
      title: data['title'],
      description: data['description'],
      price: data['price'],
      image: data['image'],
      rating: data['rating'],
      id: data['id'],
      rest_id: data['rest_id']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating,
      'id': id,
      'rest_id': rest_id
    };
  }
}
