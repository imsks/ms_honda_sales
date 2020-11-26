import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:ms_honda_sales/models/user.dart';
import 'package:ms_honda_sales/services/sharedPrefs.dart';
import 'package:ms_honda_sales/utilities/constants/values.dart';


// class AuthService {

//   String authUrl=apiBaseUrl1+"/auth";

//   Future login(String phone, String password) async {
//     Map data = {'contactNo': phone, 'password': password};
//     print(data);

//     var jsonResponse;
//     final response = await http.post(
//       Uri.encodeFull(authUrl+"/signin"),
//       body: json.encode(data),
//       headers: {"Content-Type":"application/json"}
//     );
//     //final response = await http.get("https://virestore.herokuapp.com/api/business/auth/test");
//     print("response sent");
//     print(response.statusCode);

//     if (response.statusCode == 200 || response.statusCode == 400) {
//       jsonResponse = jsonDecode(response.body);
//       //print(jsonResponse['token']);
//       print(jsonResponse['message']);
//     }
//     if (jsonResponse != null && jsonResponse['success'] == "Success") {
//       //testing as if authentication was successful
//       print("login process started");
//       print(jsonResponse['data']["_id"]);
//       String id=jsonResponse['data']["_id"];
//       String name=jsonResponse['data']["name"];
//       SharedPref sharedPref = SharedPref();
//       User userSave = User(phNo: phone, pass: password, name: name, id: id);
//       sharedPref.save("user", userSave);
//       print("UserLoggedIn\n" + "Phone:" + userSave.phNo + "\nPassword:" +
//           userSave.pass);
//       return userSave;
//     }
//     else if (jsonResponse != null && jsonResponse['success'] == "Fail") {
//       throw Exception("Credentials incorrect");

//     }
//     else {
//       print(jsonResponse['message']);
//       throw Exception("Some error occurred");
//     }
//   }

//   Future signUp({String name, String phone, String category, String password}) async {
//     Map data = {
//       "name":name,
//       "contactNo": phone,
//       "shopCategory":category,
//       "password": password
//     };

//     print(jsonEncode(data));

//     var jsonResponse;
//     final response = await http.post(
//       Uri.encodeFull(authUrl+"/signup"),
//       body: jsonEncode(data),
//       headers: {"Content-Type":"application/json"}
//     );
//     //final response = await http.get("https://virestore.herokuapp.com/api/business/auth/test");
//     print("response sent");
//     print(response.statusCode);

//     if (response.statusCode == 200) {
//       jsonResponse = json.decode(response.body);
//       //print(jsonResponse['message']);
//     }
//     else if(response.statusCode==400) {
//       jsonResponse = json.decode(response.body);
//     }

//     if (jsonResponse != null && jsonResponse['status'] == "Success") {
//       //testing as if authentication was successful
//       print("sign up process started");
//       SharedPref sharedPref = SharedPref();
//       String id=jsonResponse['data']["_id"];
//       String name=jsonResponse['data']["name"];
//       String sCat=jsonResponse['data']["shopCategory"];
//       User userSave = User(phNo: phone, pass: password, name: name, id: id);
//       sharedPref.save("user", userSave);
//       print("UserSignedUp\n" + "Phone:" + userSave.phNo + "\nPassword:" +
//           userSave.pass);
//       return userSave;
//     }

//     else {
//       throw Exception("Error Signing up");
//     }

//   }

//   signOut() async {
//     SharedPref sharedPref = SharedPref();
//     sharedPref.remove("user");
//   }
// }