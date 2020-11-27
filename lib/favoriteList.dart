import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'db.dart';
import 'dish.dart';
import 'menuItems.dart';

class FavoriteList extends StatefulWidget {
  FavoriteList() : super();

  @override
  _FavoriteState createState() {
    return _FavoriteState();
  }
}

class _FavoriteState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Favourite List',
            style:TextStyle(color: Colors.black, fontSize: 20),),
          backgroundColor: Colors.yellow[500],
          actions: [
            RaisedButton(
              color: Colors.yellow[600],
                child: Text('Go to Menu Page',style: TextStyle(fontSize: 20),),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],

        ),
        body: Column(
          children: [
            Expanded(
              child:
                  Consumer<MenuItemsModel>(builder: (context, favorite, child) {
                return ListView.builder(
                    itemCount:
                        Provider.of<MenuItemsModel>(context, listen: false)
                            .getFavoriteDishes()
                            .length,
                    itemBuilder: (BuildContext context, int index) {
                      return MenuItem(
                        dish:
                            Provider.of<MenuItemsModel>(context, listen: false)
                                .getFavoriteDishes()[index],
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Dish dish;
  // final VoidCallback deleteItem;

  MenuItem({@required this.dish});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/' + this.dish.image,
                width: 100,
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
                                size: 23.0,
                                isReadOnly: true,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_half,
                                defaultIconData: Icons.star_border,
                                color: Colors.yellowAccent[700],
                                borderColor: Colors.yellowAccent[700],
                                spacing: 0.0),
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Provider.of<MenuItemsModel>(context,
                                      listen: false)
                                      .cheak(dish)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                color: Colors.yellow[900],
                                splashColor: Colors.black,
                                focusColor: Colors.red,
                                iconSize: 22,
                                onPressed: () {
                                  Provider.of<MenuItemsModel>(context,
                                      listen: false)
                                      .setFavorite(dish);
                                }),
                            Text(
                              'Remove From Favourite',
                              style: TextStyle(fontSize: 18,color: Colors.yellow[900]),)
                          ],
                        )
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
                child: Text('Confirm'),
                onPressed: () {
                  print('confirmed successfullly');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
