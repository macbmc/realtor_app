import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:realestate_app/Counters/AddressChanger.dart';
import 'package:realestate_app/Counters/CartItemCounter.dart';
import 'package:realestate_app/Counters/ItemQuantity.dart';
import 'package:realestate_app/Counters/TotalAmt.dart';
import 'package:provider/provider.dart';
import 'package:realestate_app/Backend/Config.dart';
import 'package:realestate_app/Screen/HomeScreen.dart';
import 'package:realestate_app/Screen/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RealEstateApp.auth = FirebaseAuth.instance;
  RealEstateApp.sharedPreferences = await SharedPreferences.getInstance();
  RealEstateApp.firestore = Firestore.instance;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => ItemQuantity()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
      ],
      child: MaterialApp(
        routes: {},
        home: Scaffold(
          body: Login(),
        ),
      ),
    );
  }
}
