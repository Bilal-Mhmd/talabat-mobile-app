import 'package:flutter/cupertino.dart';
import 'dish.dart';

class MenuItemsModel extends ChangeNotifier {
  List<Dish> favoriteDishes = [];
  List<Dish> dishes = [];
  List<Dish> orderedDishes = [];

  void setDishes(List<Dish> dish) {
    this.dishes = dish;

    // for (int i = 0; i < this.dishes.length; i++) {
    //   this.favoriteDishes.forEach((element) {
    //     if ((dishes[i].id == element.id) &&
    //         (dishes[i].rest_id == element.rest_id)) {
    //       // this.dishes[i].isFavorite = true;
    //     }
    //   });
    // }
    // notifyListeners();
  }

  bool cheak(Dish dish) {
    bool flag = false;
    this.favoriteDishes.forEach((element) {
      if ((dish.id == element.id) && (dish.rest_id == element.rest_id)) {
        flag = true;
      }
    });
    return flag;
  }

  List<Dish> getFavoriteDishes() {
    return favoriteDishes;
  }

  List<Dish> getOrderedDihes() {
    return this.orderedDishes;
  }

  void orderDish(Dish dish) {
    this.orderedDishes.add(dish);
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
}
