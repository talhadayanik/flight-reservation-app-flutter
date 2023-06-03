// @dart=2.9
import 'package:flight_reservation/Screens/LoginScreen.dart';
import 'package:flight_reservation/Screens/PurchaseScreen.dart';
import 'package:flight_reservation/Screens/RegisterScreen.dart';
import 'package:flight_reservation/Screens/Homepage_Member.dart';
import 'package:flight_reservation/Screens/Homepage_Admin.dart';
import 'package:flight_reservation/Screens/AddFlightScreen.dart';
import 'package:flight_reservation/Screens/UpdateFlightScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: new LoginScreen(),
      routes: <String, WidgetBuilder>{
        '/RegisterScreen' : (BuildContext context) => RegisterScreen(),
        '/LoginScreen' : (BuildContext context) => LoginScreen(),
        '/Homepage_Member' : (BuildContext context) => Homepage_Member(),
        '/PurchaseScreen' : (BuildContext context) => PurchaseScreen(),
        '/Homepage_Admin' : (BuildContext context) => Homepage_Admin(),
        '/AddFlightScreen' : (BuildContext context) => AddFlightScreen(),
        '/UpdateFlightScreen' : (BuildContext context) => UpdateFlightScreen(),
      },
    );
  }
}