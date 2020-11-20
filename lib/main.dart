import 'package:flutter/material.dart';
import 'package:ms_honda_sales/screens/auth/login_screen.dart';
import 'package:ms_honda_sales/screens/cars/dashboard.dart';
import 'package:ms_honda_sales/screens/static/splash_screen.dart';
import 'package:ms_honda_sales/services/wrapper.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';

// import 'models/cart.dart';
// import 'models/user.dart';

void main() {
  runApp(MSHondaSales());
}

class MSHondaSales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: kFontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(
              backgroundColor: const [
                Colors.white,
              ],
              duration: 1,
              nextScreenPath: Wrapper.id,
              debug: false,
            ),
        // LoginScreen.id: (context) => LoginScreen(),
        // CarsShowcase.id: (context) => CarsShowcase(),
        Wrapper.id: (context) => Wrapper(),
      },
    );
  }
}
