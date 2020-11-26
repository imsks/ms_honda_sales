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
    // https://ms-honda-sales-app.herokuapp.com/api/admin/cars/get-car-data?carName=Amaze&carModel=1.2%20EMT&carType=Petrol
    final response = await http.get(
      Uri.encodeFull(baseCarUrl + "/get-all-cars/"),
    );

    return jsonDecode(response.body)["data"];
  }

  // Get All Cars Data
  getACarData(String carName, String carModel, String carType) async {
    // print(carName);
    // print(carModel);
    // print(carType);

    print(baseCarUrl +
        '/get-car-data/?carName=$carName&carModel=$carModel&carType=$carType');
    // Send the response
    final response = await http.get(
      Uri.encodeFull('https://ms-honda-sales-app.herokuapp.com/api/admin/cars/get-car-data/?carName=Amaze&carModel=1.2%20EMT&carType=Petrol'),
    );

    return jsonDecode(response.body)["data"]["data"];
  }
}

// class ShopService {

//   String shopUrl=apiBaseUrl1;

//   getShopList(String location) async {
//     List<Shop> shopList=[];
//     var jsonResponse;
//     final response = await http.get(
//         Uri.encodeFull(shopUrl+"/view-shops-by-location/"+location),
//         headers: {"Content-Type":"application/json"}
//     );

//     //statusCode 404 to be removed later
//     if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 404) {
//       jsonResponse = getShopMap;
//     }
//     if(jsonResponse != null && jsonResponse['status'] == "Success") {
//       for (Map i in jsonResponse['data']) {
//         shopList.add(Shop.fromJson(i));
//         print(i['name']);
//         print(Shop.fromJson(i).name);
//       }
//     }
//     return shopList;
//   }

//   getProdList(String shopId) async{
//     List<Product> prodList=[];
//     var jsonResponse;
//     final response = await http.get(
//         Uri.encodeFull(shopUrl+"/view-all-products-by-shop/"+shopId),
//         headers: {"Content-Type":"application/json"}
//     );

//     //statusCode 404 to be removed later
//     if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 404) {
//       jsonResponse = getProducts;
//       print(jsonResponse);
//     }
//     if(jsonResponse != null && jsonResponse['status'] == "Success") {
//       for (Map i in jsonResponse['data']) {
//         prodList.add(Product.fromJson(i));
//         //print(i['productName']);
//         //print(Product.fromJson(i).name);
//       }
//     }
//     return prodList;
//   }
// }
