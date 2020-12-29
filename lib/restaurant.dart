import 'package:google_maps_flutter/google_maps_flutter.dart';

class Restaurant {
  int id;
  String name;
  String city;
  int rating;
  String image;
  double weight;
  double lat;
  double lng;
  Marker marker;

  // ignore: sort_constructors_first
  Restaurant({this.name, this.city, this.rating, this.image, this.id, this.lat, this.lng}){
    marker = Marker(
      markerId: MarkerId(name),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: name),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange
      ),
    );
  }

  factory Restaurant.fromJson(dynamic jsonObject) {
    return Restaurant(
      name: jsonObject['name'] as String,
      city: jsonObject['city'] as String,
      rating: jsonObject['rating'] as int,
      image: 'http://appback.ppu.edu/static/${jsonObject['image']}',
      id: jsonObject['id'] as int,
      lat: double.parse(jsonObject['lat']),
      lng: double.parse(jsonObject['lng']),
    );
  }

}




