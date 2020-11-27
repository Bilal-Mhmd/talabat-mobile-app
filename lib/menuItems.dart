import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/favoriteList.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:convert';
import 'dish.dart';
import 'package:restaurant/ordered.dart';

class MenuItemsList extends StatefulWidget {
  // This widget is the root of your application.

  int id;
  MenuItemsList();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MenuItemsList> {
  List<Dish> orderedDishes = [];
  List<int> favoriteDishesIndices = [];
  int id;

  _MyAppState();

  // Future<List<Dish>> futureDishes;

  // Future<List<Dish>> fetchMenuItems() async {
  //   final http.Response response =
  //       await http.get("https://api.androidhive.info/json/movies.json");

  //   if (response.statusCode == 200) {
  //     // success, parse json data
  //     List jsonArray = jsonDecode(response.body);
  //     List<Dish> dishes = jsonArray.map((x) => Dish.fromJson(x)).toList();
  //     return dishes;
  //   } else {
  //     throw Exception("Failed to load data");
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   this.futureDishes = fetchMenuItems();
  //   Provider.of<MenuItemsModel>(context, listen: false)
  //       // .setDishes(this.futureDishes);
  // }

  // void _setFavorite(int index) {
  //   Provider.of<MenuItemsModel>(context, listen: false).setFavorite(index);
  //   setState(() {});
  // }

  void _order(int index) {
    this
        .orderedDishes
        .add(Provider.of<MenuItemsModel>(context, listen: false).dishes[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[500],
        title: Text('Menu',style: TextStyle(fontSize: 15, color: Colors.black),),
        actions: [
          RaisedButton(
              color: Colors.yellow[600],
              hoverColor: Colors.yellow[500],
              splashColor: Colors.yellow[500],
              focusColor: Colors.yellow[400],
              child: Row(
                children: [
                  Icon(Icons.bookmark_border , size: 20,),
                  Text('OrderedPage',style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderedList(),
                  ),
                );
              }),
          RaisedButton(
              color: Colors.yellow[600],
              hoverColor: Colors.yellow[500],
              splashColor: Colors.yellow[500],
              focusColor: Colors.yellow[400],
              child: Row(
                children: [
                  Icon(Icons.favorite_border, size: 20,),
                  Text(' FavoritePage', style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteList(),
                  ),
                );
              }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MenuItemsModel>(
              builder: (context, mentuItems, child) {
                return ListView.builder(
                  itemCount: Provider.of<MenuItemsModel>(context, listen: false)
                      .dishes
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return MenuItem(
                      dish: Provider.of<MenuItemsModel>(context, listen: false)
                          .dishes[index],
                      orderDish: () {
                        _order(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Dish dish;
  final VoidCallback orderDish;
  // final VoidCallback addToFavorite;

  MenuItem({@required this.dish, this.orderDish});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/' + this.dish.image,
                width: 150,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.dish.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(this.dish.description),
                    SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 10,
                          rating: 7,
                          size: 22.0,
                          isReadOnly: true,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          defaultIconData: Icons.star_border,
                          color: Colors.yellowAccent[700],
                          borderColor: Colors.yellowAccent[700],
                          spacing: 0.0) ,

                    Row(
                      children: [
                        Consumer<MenuItemsModel>(
                                builder: (context, dishes, child) {
                              return IconButton(
                                  icon: Icon(
                                    Provider.of<MenuItemsModel>(context,
                                                listen: false)
                                            .cheak(dish)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),
                                  color: Colors.yellow[900],
                                  splashColor: Colors.black,
                                  highlightColor: Colors.yellow[900],
                                  focusColor: Colors.red,
                                  iconSize: 22,
                                  onPressed: () {
                                    Provider.of<MenuItemsModel>(context,
                                            listen: false)
                                        .setFavorite(dish);
                                  });
                            }),
                        Text('Add To Favourite', style: TextStyle(fontSize: 16,color: Colors.yellow[900]),)
                      ],
                    ),


                  ],
                ),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Colors.yellowAccent[200],
                hoverColor: Colors.yellow[400] ,
                splashColor: Colors.yellow[400],
                focusColor: Colors.yellow[400],
                child: Text('Order'),
                onPressed: () {
                  Provider.of<MenuItemsModel>(context, listen: false)
                      .orderDish(dish);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
