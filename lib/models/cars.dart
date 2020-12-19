import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarDetailsProvider with ChangeNotifier {
  List<String> currentCarDetails = ["Amaze", "Petrol", "1.2 EMT P"];

  List<String> addOnNames = [];
  List<String> addOnValues = [];
  bool isAddOnsIncluded = false;

  List<String> get getCarDetails {
    return currentCarDetails;
  }

  List<String> get getAddOnNames {
    return addOnNames;
  }

  List<String> get getAddOnValues {
    return addOnValues;
  }

  bool get getAddOnIncludeStatus {
    return isAddOnsIncluded;
  }

  void updateCarDetails(num index, String data) {
    currentCarDetails.removeAt(index);
    currentCarDetails.insert(index, data);
    notifyListeners();
  }

  void setAddOnName(List<String> data) {
    addOnNames = data;
    notifyListeners();
  }

  void setAddOnValue(List<String> data) {
    addOnValues = data;
    notifyListeners();
  }

  void setAddOnIncludedStatus(bool value) {
    isAddOnsIncluded = value;
    notifyListeners();
  }
}
