import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:restaurant/restaurant.dart';
import 'dish.dart';

class MenuItemsModel extends ChangeNotifier {
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
    return this._restaurants;
  }

  List<Dish> getDishes() {
    return this._dishes;
  }

  List<Dish> getOrderedDihes() {
    return this.orderedDishes;
  }

  void orderDish(Dish dish) {
    orderedDishes.add(dish);
    notifyListeners();
  }

  void unOrderDish(Dish dish) {
    if (this.orderedDishes.indexOf(dish) != -1) {
      this.orderedDishes.remove(dish);
      notifyListeners();
    }
  }

  bool existInFavorite(Dish dish) {
    return favoriteDishes.indexOf(dish) != -1 ? true : false;
  }

  void setFavorite(Dish dish) {
    if (existInFavorite(dish)) {
      favoriteDishes.remove(dish);
    } else {
      favoriteDishes.add(dish);
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
