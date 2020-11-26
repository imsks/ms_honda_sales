import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:ms_honda_sales/models/product.dart';
// import 'package:ms_honda_sales/models/shop.dart';
import 'package:ms_honda_sales/utilities/constants/values.dart';

class CarService {
  String baseCarUrl = apiBaseUrl + "/admin/cars";

  // Get All Cars Data
  getAllCarsData() async {
    // Send the response
    final response = await http.get(
      Uri.encodeFull(baseCarUrl + "/get-all-cars/"),
    );

    return jsonDecode(response.body)["data"];
  }

  // Get All Cars Data
  getACarData(String carName, String carModel, String carType) async {
    // carModel = carModel.replaceAll(" ", '%20');
    print(baseCarUrl + '/get-car-data/$carName/$carModel/$carType');
    // Send the response
    final response = await http.get(
      Uri.encodeFull(
          'https://ms-honda-sales-app.herokuapp.com/api/admin/cars/get-car-data/$carName/$carModel/$carType'),
    );
    

    if (jsonDecode(response.body)["status"] == "Success") {
      return jsonDecode(response.body)["data"]["data"];
    } else {
      // print(jsonDecode(response.body)["message"]);
      return jsonDecode(response.body);
    }
  }
}
