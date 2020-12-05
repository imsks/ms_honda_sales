import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:ms_honda_sales/models/user.dart';
import 'package:ms_honda_sales/services/sharedPrefs.dart';
import 'package:ms_honda_sales/utilities/constants/values.dart';

class AuthService {
  String baseAuthUrl = apiBaseUrl + "/user/auth";

  // Login
  Future login(String userName, password) async {
    Map data = {'userName': userName, 'password': password};
    final response = await http.post(Uri.encodeFull(baseAuthUrl + "/signin"),
        body: json.encode(data), headers: {"Content-Type": "application/json"});

    // If Login success
    if (response.statusCode == 200) {
      // Save data in local
      SharedPref sharedPref = SharedPref();
      sharedPref.save("user", jsonDecode(response.body)["data"]);
      return jsonDecode(response.body)["data"];
    }
    // Else Login Fails
    else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  // Login
  Future signup(String userName, password) async {
    Map data = {'userName': userName, 'password': password};
    final response = await http.post(Uri.encodeFull(baseAuthUrl + "/signup"),
        body: json.encode(data), headers: {"Content-Type": "application/json"});

    // If Login success
    if (response.statusCode == 200) {
      // Save data in local
      SharedPref sharedPref = SharedPref();
      sharedPref.save("user", jsonDecode(response.body)["data"]);
      return jsonDecode(response.body)["data"];
    }
    // Else Login Fails
    else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }
}
