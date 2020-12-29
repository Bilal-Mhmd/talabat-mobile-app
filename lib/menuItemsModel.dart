import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:restaurant/database_provider.dart';
import 'package:restaurant/restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'dish.dart';

class MenuItemsModel extends ChangeNotifier{
  List<Dish> favoriteDishes = [];
  List<Dish> _dishes = [];
  List<Dish> orderedDishes = [];
  List<Restaurant> _restaurants = [];



  void setDishes(List<Dish> dish) {
    this._dishes = dish;
  }

  void setRestaurants(List<Restaurant> restaurants) {
    List<Restaurant> rest = filter(restaurants);
    this._restaurants = rest;
  }

  List<Restaurant> filter(List<Restaurant> list) {
    int city = 0;

    for (int i = 0; i < list.length; i++) {
      if (list[i].city == 'Hebron') {
        city = 10;
      } else {
        city = 5;
      }
      list[i].weight = (list[i].rating + city) / 2;
    }

    list.sort((a, b) => b.weight.compareTo(a.weight));
    return list;
  }

  bool cheakFavorite(Dish dish) {
    return this.favoriteDishes.indexOf(dish) != -1 ? true : false;
  }

  List<Dish> getFavoriteDishes() {
    return favoriteDishes;
  }

  List<Restaurant> getRestaurants() {
    return _restaurants;
  }

  List<Dish> getDishes() {
    return _dishes;
  }

  List<Dish> getOrderedDihes() {
    return orderedDishes;
  }

  void orderDish(Dish dish) {
    orderedDishes.add(dish);
    notifyListeners();
  }

  void unOrderDish(Dish dish) {
    if (orderedDishes.contains(dish)) {
      orderedDishes.remove(dish);
      notifyListeners();
    }
  }

  bool existInFavorite(Dish dish) {
    return favoriteDishes.contains(dish) ? true : false;
  }

  void setFavorite(Dish dish) {
    if (existInFavorite(dish)) {
      favoriteDishes.remove(dish);
      DatabaseProvider.db.removeFromFavourites(dish.id);
    } else {
      favoriteDishes.add(dish);
      DatabaseProvider.db.insertFavorite(dish).then((value) => print(value));
    }
    notifyListeners();
  }

  void removeFromFavorite(Dish dish) {
    if (existInFavorite(dish)) {
      this.favoriteDishes.remove(dish);
    }
    notifyListeners();
  }

  String findRest(int restId) {
    String restName = 'Unknown Restaurant';
    for (int i = 0; i < _restaurants.length; i++) {
      if (_restaurants[i].id == restId) {
        restName = _restaurants[i].name;
      }
    }
    return restName;
  }
}
