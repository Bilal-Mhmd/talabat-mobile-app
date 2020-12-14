import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'dish.dart';
import 'item.dart';
import 'favoriteList.dart';
import 'menuItemsModel.dart';

class OrderedList extends StatefulWidget {
  @override
  _OrderedState createState() => _OrderedState();
}

class _OrderedState extends State<OrderedList> {
  _OrderedState();

  double _calculate() {
    double total = 0;

    Provider.of<MenuItemsModel>(context, listen: false)
        .orderedDishes
        .forEach((element) {
      total += element.price;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[500],
          title: Text('  Ordered List',
              style: TextStyle(fontSize: 19, color: Colors.black)),
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
                    Text(' Favorite List',
                        style: TextStyle(fontSize: 17)),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteList(),
                    ),
                  );
                }),
            RaisedButton(
                color: Colors.yellow[800],
                hoverColor: Colors.yellow[500],
                splashColor: Colors.yellow[500],
                focusColor: Colors.yellow[400],
                child: Text(' Back ',
                    style: TextStyle(fontSize: 17,)),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<MenuItemsModel>(builder: (context, menuI, child) {
                return ListView.builder(
                  itemCount: Provider.of<MenuItemsModel>(context, listen: false)
                      .getOrderedDihes()
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderedItem(
                      dish: Provider.of<MenuItemsModel>(context, listen: false)
                          .getOrderedDihes()[index],
                    );
                  },
                );
              }),
            ),
            Consumer<MenuItemsModel>(builder: (context, price, child) {
              return Container(
                margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                height: 50,
                width: double.infinity,
                color: Colors.yellowAccent[200],
                child: Center(
                  child: Text('Total Price to Pay: ${_calculate()}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class OrderedItem extends StatelessWidget {
  final Dish dish;

  OrderedItem({@required this.dish});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsetsDirectional.fromSTEB(0, 9, 0, 0),
            width: double.infinity,
            color: Colors.yellow,
            child: Center(
              child: Text(
                '${Provider.of<MenuItemsModel>(context, listen: false).findRest(dish.rest_id)}',
              ),
            ),
          ),
          Item(
            title: dish.title,
            image: dish.image,
            rating: dish.rating,
            description: dish.description,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 1),
                child: RaisedButton(
                  child: Text('    delete     '),
                  color: Colors.red,
                  hoverColor: Colors.yellow[400],
                  splashColor: Colors.yellow[400],
                  focusColor: Colors.yellow[400],
                  textColor: Colors.white,
                  onPressed: () {
                    Provider.of<MenuItemsModel>(context, listen: false)
                        .unOrderDish(dish);
                  },
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(5, 0, 7, 1),
                child: RaisedButton(
                  child: Text('   Confirm   '),
                  color: Colors.amber[900],
                  hoverColor: Colors.yellow[400],
                  splashColor: Colors.yellow[400],
                  focusColor: Colors.yellow[400],
                  textColor: Colors.white,
                  onPressed: () {
                    Toast.show('Order sent Successfuly', context, duration: 2);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
