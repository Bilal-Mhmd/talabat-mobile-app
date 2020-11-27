import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/main.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dish.dart';
import 'menuItemsModel.dart';

class OrderedList extends StatefulWidget {
  // final List<Dish> orderedDishes;
  // OrderedList({this.orderedDishes}) : super();

  @override
  _OrderedState createState() => _OrderedState();
}

class _OrderedState extends State<OrderedList> {
  // List<Dish> orderedDishes;
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
            title: Text('Ordered List',style: TextStyle(fontSize: 19, color: Colors.black)),
          actions: [
            RaisedButton(
                color: Colors.yellow[600],
                hoverColor: Colors.yellow[500],
                splashColor: Colors.yellow[500],
                focusColor: Colors.yellow[400],
                child: Text(' Go to Menu Page', style: TextStyle(fontSize: 19, color: Colors.black)),
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
                    return MenuItem(
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                              //double.parse('${this.dish.rating}')
                            child: SmoothStarRating(
                                allowHalfRating: false,
                                onRated: (v) {},
                                starCount: 10,
                                rating: 7,
                                size: 23.0,
                                isReadOnly: true,
                                filledIconData: Icons.star,
                                defaultIconData: Icons.star_border,
                                color: Colors.yellowAccent[700],
                                borderColor: Colors.yellowAccent[700],
                                spacing: 0.0)
                          ),
                        )
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
                child: Text('delete'),
                color: Colors.amber[800],
                textColor: Colors.white,
                onPressed: () {
                  Provider.of<MenuItemsModel>(context, listen: false)
                      .unOrderDish(dish);
                },
              ),
              RaisedButton(

                child: Text('Confirm'),
                color: Colors.amber,
                textColor: Colors.white,
                onPressed: () {
                  print('confirmed successfully');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
