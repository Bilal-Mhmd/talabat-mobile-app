import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'package:toast/toast.dart';
import 'dish.dart';
import 'item.dart';
import 'ordered.dart';

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
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          backgroundColor: Colors.yellow[500],
          actions: [
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
                    Text('OrderedPage',
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderedList(),
                    ),
                  );
                }),
            RaisedButton(
                color: Colors.yellow[800],
                hoverColor: Colors.yellow[500],
                splashColor: Colors.yellow[500],
                focusColor: Colors.yellow[400],
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 20),
                ),
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
                          return FavoriteItem(
                            dish: Provider.of<MenuItemsModel>(context, listen: false)
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

class FavoriteItem extends StatelessWidget {
  final Dish dish;

  FavoriteItem({@required this.dish});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Item(
          title: dish.title,
          image: dish.image,
          rating: dish.rating,
          description: dish.description,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Provider.of<MenuItemsModel>(context, listen: false)
                    .setFavorite(dish);
              },
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Provider.of<MenuItemsModel>(context, listen: false)
                                .cheakFavorite(dish)
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      color: Colors.yellow[900],
                      splashColor: Colors.black,
                      focusColor: Colors.red,
                      iconSize: 22,
                      onPressed: () {
                        Provider.of<MenuItemsModel>(context, listen: false)
                            .setFavorite(dish);
                      }),
                  Text(
                    'Remove From Favourite',
                    style: TextStyle(fontSize: 18, color: Colors.yellow[900]),
                  ),
                ],
              ),
            ),
            RaisedButton(
              color: Colors.amber[900],
              textColor: Colors.white,
              hoverColor: Colors.yellow[400],
              splashColor: Colors.yellow[400],
              focusColor: Colors.yellow[400],
              child: Text('Order'),
              onPressed: () {
                Provider.of<MenuItemsModel>(context, listen: false)
                    .orderDish(dish);
                Toast.show('Ordered Successfuly', context, duration: 2);
              },
            ),
          ],
        ),
      ]),
    );
  }
}
