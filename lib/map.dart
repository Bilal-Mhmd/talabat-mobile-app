import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant/restaurant.dart';
import 'package:restaurant/resturantsMainPage.dart';



class MyMap extends StatefulWidget {

  final List<Restaurant> restaurants;
  MyMap(this.restaurants);

  @override
  _MyMapState createState() => _MyMapState(this.restaurants);
}

class _MyMapState extends State<MyMap> {
  List<Restaurant> restaurants = [];
  _MyMapState(this.restaurants);
  Set<Marker> markers  = {hebronMarker};

  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  void initState() {
    restaurants.forEach((res) => this.markers.add(res.marker));
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Restaurants Map', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.yellow[700],
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(31.533702181365562, 35.10008344499284),
                zoom: 8.0,
              ),
              markers: markers
            ),

          ],
        ),
      ),
    );
  }

}


Marker hebronMarker = Marker(
    markerId: MarkerId('hebron'),
    position: LatLng(31.533702181365562, 35.10008344499284),
    infoWindow: InfoWindow(title: 'Hebron'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueOrange
    ),
);








//
// Widget googlMap(BuildContext context){
//   return Container(
//     height: MediaQuery.of(context).size.height,
//     width: MediaQuery.of(context).size.width,
//     child: GoogleMap(
//       mapType: MapType.normal,
//       initialCameraPosition: CameraPosition(target: LatLng(31.533702181365562, 35.10008344499284),zoom: 12),
//       onMapCreated: _onMapCreated,
//
//     ),
//   );
// }