import 'package:restaurant/dish.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static final int version = 1;
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    path += 'restaurants.db';
    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        await db.execute('''
          create table products (
            title text not null,
            description text not null,
            price real not null,
            image text not null,
            rating integer not null,
            id integer primary key,
            rest_id integer,   
          )
          ''');
      },
    );
  }

  Future<List<Dish>> get products async {
    final db = await database;
    List<Map> result = await db.query('restaurants', orderBy: 'id asc');
    var dishes = <Dish>[];
    for (var value in result) {
      dishes.add(Dish.fromMap(value));
    }
    return dishes;
  }

  Future insert(Dish dish) async {
    final db = await database;

    return await db.insert('restaurants', dish.toMap());
  }

  Future<Dish> getProduct(int id) async {
    final db = await database;
    List<Map> dish =
    await db.query('products', where: 'id=?', whereArgs: [id]);
    return Dish.fromMap(dish[0]);
  }

  Future removeAll() async {
    final db = await database;
    return await db.delete('dishes');
  }

  Future<int> removeRestaurant(int id) async {
    final db = await database;
    return await db.delete('dishes', where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateProduct(Dish dish) async {
    final db = await database;
    return await db.update('restaurants', dish.toMap(),
        where: 'id=?', whereArgs: [dish.id]);
  }
}