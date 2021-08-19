import 'package:flutter/foundation.dart';
import 'package:realestate_app/Backend/Config.dart';

class CartItemCounter extends ChangeNotifier {
  int _counter = RealEstateApp.sharedPreferences
          .getStringList(RealEstateApp.userwishList)
          .length -
      1;
  int get count => _counter;
  Future<void> displayResult() async {
    int _counter = RealEstateApp.sharedPreferences
            .getStringList(RealEstateApp.userwishList)
            .length -
        1;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
