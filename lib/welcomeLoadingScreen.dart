import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'package:restaurant/resturantsMainPage.dart';
import 'restaurant.dart';
import 'package:toast/toast.dart';

class WelcomeLoadingScreen extends StatefulWidget {
  @override
  _WelcomeLoadingScreenState createState() => _WelcomeLoadingScreenState();
}

class _WelcomeLoadingScreenState extends State<WelcomeLoadingScreen> {
  List<Restaurant> restaurants = [];
  void fetchRestaurants() async {
    http.Response response =
        await http.get('http://appback.ppu.edu/restaurants');
    if (response.statusCode == 200) {
      //success, parse json data
      List jsonRestaurantArray = jsonDecode(response.body);
      restaurants = jsonRestaurantArray
          .map((element) => Restaurant.fromJson(element))
          .toList();
      Provider.of<MenuItemsModel>(context, listen: false)
          .setRestaurants(restaurants);
    } else {
      Toast.show('Cannot fetch data', context, duration: Toast.LENGTH_LONG);
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RestaurantMainPage(restaurants)));
  }

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[700],
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.all(18),
            child: Text(
              'Welcome To TALABAT',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Relway',
                  fontWeight: FontWeight.w900),
            ),
          ),
          SpinKitRing(
            color: Colors.black,
            size: 50.0,
          ),
        ]),
      ),
    );
  }
}
