import 'package:flutter/cupertino.dart';
import 'package:ms_honda_sales/screens/auth/login_screen.dart';
import 'package:ms_honda_sales/screens/cars/dashboard.dart';
import 'package:ms_honda_sales/services/auth_service.dart';
import 'package:ms_honda_sales/services/sharedPrefs.dart';

class Wrapper extends StatelessWidget {
  static const String id = 'wrapper';
  AuthService auth = new AuthService();
  @override
  Widget build(BuildContext context) {
    SharedPref sharedPref = SharedPref();
    Future loadSharedPrefs() async {
      try {
        var data = await sharedPref.read("user");
        print(data);
        if (data != null) {
          return true;
        } else {
          return false;
        }
      } catch (Exception) {
        return false;
      }
    }

    return FutureBuilder(
      future: loadSharedPrefs(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data) {
            return CarsShowcase();
          } else
            return LoginScreen();
        } else {
          return Container();
        }
      },
    );
  }
}
