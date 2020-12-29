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
    var path = await getDatabasesPath();
    path += 'favorites.db';
    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        await db.execute('''
          create table favorites (
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

  Future<List<Dish>> get favorites async {
    final db = await database;
    List<Map> result = await db.query('restaurants', orderBy: 'id asc');
    var dishes = <Dish>[];
    for (var value in result) {
      dishes.add(Dish.fromMap(value));
    }
    return dishes;
  }

  Future insertFavorite(Dish dish) async {
    final db = await database;
    return await db.insert('favorites', dish.toMap());
  }

  Future<Dish> getFavourites(int id) async {
    final db = await database;
    List<Map> dish =
    await db.query('favorites', where: 'id=?', whereArgs: [id]);
    return Dish.fromMap(dish[0]);
  }

  Future removeAll() async {
    final db = await database;
    return await db.delete('favorites');
  }

  Future<int> removeFromFavourites(int id) async {
    final db = await database;
    return await db.delete('favorites', where: 'id=?', whereArgs: [id]);
  }


}