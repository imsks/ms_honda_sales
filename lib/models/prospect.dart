import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProspectDataProvider with ChangeNotifier {
  List<Map<String, String>> currentProspectData = List<Map<String, String>>();

  List<Map<String, String>> get getProspectData {
    return currentProspectData;
  }

  void updateProspectData(List<Map<String, String>> data) {
    currentProspectData = data;
  }
}
