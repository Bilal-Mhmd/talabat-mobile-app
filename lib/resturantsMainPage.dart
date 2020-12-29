import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/item.dart';
import 'package:restaurant/favoriteList.dart';
import 'package:restaurant/loadingMenus.dart';
import 'package:restaurant/map.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'package:restaurant/ordered.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'restaurant.dart';

class RestaurantMainPage extends StatefulWidget {
  final List<Restaurant> restaurants;
  RestaurantMainPage(this.restaurants);
  @override
  _RestaurantMainPageState createState() =>
      _RestaurantMainPageState(restaurants);
}

class Waiter {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Waiter({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _RestaurantMainPageState extends State<RestaurantMainPage> {
  _RestaurantMainPageState(this.restaurants);
  List<Restaurant> restaurants = [];
  List<Restaurant> filteredRestaurants = [];

  final _waiter = Waiter(milliseconds: 500);


  @override
  void initState() {
    setState(() {
      restaurants.sort((a,b)=>a.rating.compareTo(b.rating));
      filteredRestaurants = restaurants;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyMap(this.filteredRestaurants),
                    ));
              },
              child: Icon(Icons.location_on),
              backgroundColor: Colors.yellow[700],

            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.yellow[500],
          title: Row(
            children: [
              Icon(
                Icons.restaurant,
                size: 18,
                color: Colors.black,
              ),
              Text(
                ' Restaurants',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
          actions: [
            RaisedButton(
              color: Colors.yellow[800],
              hoverColor: Colors.yellow[500],
              splashColor: Colors.yellow[500],
              focusColor: Colors.yellow[400],
              child: Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 20,
                  ),
                  Text('FavouriteList'),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteList(),
                    ));
              },
            ),
            RaisedButton(
              color: Colors.yellow[800],
              hoverColor: Colors.yellow[500],
              splashColor: Colors.yellow[500],
              focusColor: Colors.yellow[400],
              child: Row(
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 20,
                  ),
                  Text('OrderedList'),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderedList(),
                    ));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(14.9),
                hintText: 'Enter city name',
              ),
              onChanged: (string){
                _waiter.run(() {
                  setState(() {
                    filteredRestaurants = restaurants
                        .where((res) => (res
                        .city.toLowerCase()
                        .contains(string.toLowerCase()))).toList();
                  });
                });
              },
            ),
            Expanded(
              child: Provider.of<MenuItemsModel>(context, listen: false)
                          .getRestaurants()
                          .length >
                      0
                  ? ListView.builder(
                      reverse: true,
                      itemCount: filteredRestaurants.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                            margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: RestaurantItem(filteredRestaurants[index])
                        );
                      },
                    )
                  : Center(
                      child: Text('No Restaurants found!'),
                    ),
            ),
          ],
        ));
  }
}

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantItem(this.restaurant);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Item(
              title: restaurant.name,
              image: restaurant.image,
              description: 'city: ${restaurant.city}',
              rating: restaurant.rating.toDouble(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(0, 1, 7, 1),
                  child: RaisedButton(
                      color: Colors.yellow[600],
                      hoverColor: Colors.yellow[400],
                      splashColor: Colors.yellow[400],
                      focusColor: Colors.yellow[400],
                      child: Text('  Show Menu '),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoadingMenus(this.restaurant.id)));
                      }),
                ),
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(1, 1, 6, 1),
                  child: RaisedButton(
                      color: Colors.yellow[800],
                      hoverColor: Colors.yellow[600],
                      splashColor: Colors.yellow[600],
                      focusColor: Colors.yellow[400],
                      child: Text('Rate'),
                      onPressed: () {
                        _showDialog(context);
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlertDialog(
                title: Text('Rate ${this.restaurant.name} Restaurant'),
                content: Column(
                  children: [
                    SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (value) {},
                        starCount: 5,
                        rating: 0,
                        size: 24.0,
                        isReadOnly: false,
                        filledIconData: Icons.star,
                        defaultIconData: Icons.star_border,
                        color: Colors.yellowAccent[700],
                        borderColor: Colors.yellowAccent[700],
                        spacing: 0.0),
                    FlatButton(
                      child: Text('Close!'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
