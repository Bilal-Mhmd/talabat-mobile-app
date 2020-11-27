import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/favoriteList.dart';
import 'package:restaurant/loadingMenus.dart';
import 'package:restaurant/menuItems.dart';
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

class _RestaurantMainPageState extends State<RestaurantMainPage> {
  List<Restaurant> restaurants = [];
  _RestaurantMainPageState(this.restaurants);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[500],
        title: Text('Restaurant List', style:TextStyle(fontSize: 14, color: Colors.black),),
        actions: [
          RaisedButton(
            color: Colors.yellow[600],
            hoverColor: Colors.yellow[500],
            splashColor: Colors.yellow[500],
            focusColor: Colors.yellow[400],
            child: Row(
              children: [
                Icon(Icons.favorite_border, size: 20,),
                Text(' Favourite List'),
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
            color: Colors.yellow[600],
            hoverColor: Colors.yellow[500] ,
            splashColor: Colors.yellow[500],
            focusColor: Colors.yellow[400],
            child: Row(
              children: [
                Icon(Icons.bookmark_border , size: 20,),
                Text(' Ordered List'),
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
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, index) {
          return RestaurantItem(
            restaurants[index].restaurantName,
            restaurants[index].city,
            restaurants[index].rating,
            restaurants[index].image,
            restaurants[index].id,
          );
        },
      ),
    );
  }
}

class RestaurantItem extends StatelessWidget {
  final String restaurantName;
  final String city;
  final int rating;
  final String image;
  final int id;
  RestaurantItem(
      this.restaurantName, this.city, this.rating, this.image, this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Image(image: NetworkImage('$image')),
                Column(
                  children: [
                    Text(this.restaurantName),
                    Text(this.city),
                    SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 10,
                        rating: double.parse('${this.rating}'),
                        size: 22.0,
                        isReadOnly: true,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        color: Colors.yellow,
                        borderColor: Colors.yellow,
                        spacing: 0.0)
                  ],
                )
              ],
            ),
            Row(
              
              children: [
                RaisedButton(
                    color: Colors.yellowAccent[200],
                    hoverColor: Colors.yellow[400] ,
                    splashColor: Colors.yellow[400],
                    focusColor: Colors.yellow[400],
                    child: Text('Show Menu Items'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingMenus(this.id)));
                    }),
                RaisedButton(
                    color: Colors.yellowAccent[200],
                    hoverColor: Colors.yellow[400] ,
                    splashColor: Colors.yellow[400],
                    focusColor: Colors.yellow[400],
                    child: Text('Rate'),
                    onPressed: () {
                      _showDialog(context);
                    })
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
                title: Text('Rate ${this.restaurantName} Restaurant'),
                content: Column(
                  children: [
                    SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (value) {
                        },
                        starCount: 10,
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
                actions: [],
              ),
            ],
          ),
        );
      },
    );
  }
}
