import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarDetailsProvider with ChangeNotifier {
  List<String> currentCarDetails = ["Amaze", "Petrol", "1.2 EMT P"];

  List<String> get getCarDetails {
    return currentCarDetails;
  }

  void updateCarDetails(num index, String data) {
    currentCarDetails.removeAt(index);
    currentCarDetails.insert(index, data);
    notifyListeners();
  }
}
