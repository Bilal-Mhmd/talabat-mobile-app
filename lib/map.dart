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

  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

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
                zoom: 12.0,
              ),
              markers: markers
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 150,
                child: ListView.builder(
                  reverse: true,
                  itemCount: restaurants.length,
                  itemBuilder: (BuildContext context, index) {
                    markers.add(restaurants[index].marker);
                    return Container(
                        margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: RestaurantItem(restaurants[index])
                    );
                  },
                )
              ),
            )

          ],
        ),
      ),
    );
  }

}

Set<Marker> markers  = {hepronMarker};

Marker hepronMarker = Marker(
    markerId: MarkerId('hepron'),
    position: LatLng(31.533702181365562, 35.10008344499284),
    infoWindow: InfoWindow(title: "Hepron City"),
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