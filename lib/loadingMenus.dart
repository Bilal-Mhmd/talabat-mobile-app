import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'dish.dart';
import 'menuItems.dart';

class LoadingMenus extends StatefulWidget {
  int id;
  LoadingMenus(this.id) : super();

  @override
  _LoadingState createState() => _LoadingState(this.id);
}

class _LoadingState extends State<LoadingMenus> {
  int id;
  _LoadingState(this.id);
  List<Dish> dishes = [];
  void fetchMenuItems() async {
    final http.Response response =
        await http.get("http://appback.ppu.edu/menus/$id");

    if (response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body) as List;
      print(jsonArray[0]);
      dishes = jsonArray.map((e) => Dish.fromJson(e)).toList();
      Provider.of<MenuItemsModel>(context, listen: false).setDishes(dishes);
    } else {
      throw Exception("Failed to load data");
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MenuItemsList(),
        ));
  }

  @override
  void initState() {
    super.initState();
    fetchMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[900],
      body: Center(
        child: SpinKitPouringHourglass(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
