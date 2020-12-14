import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/menuItemsModel.dart';
import 'package:restaurant/welcomeLoadingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MenuItemsModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: WelcomeLoadingScreen(),
        ));
  }
}
