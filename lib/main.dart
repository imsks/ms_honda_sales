import 'package:flutter/material.dart';
import 'package:ms_honda_sales/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:ms_honda_sales/screens/cars/dashboard.dart';
import 'package:ms_honda_sales/screens/static/splash_screen.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';

// import 'models/cart.dart';
// import 'models/user.dart';

void main() {
  runApp(VireStoreUserApp());
}

class VireStoreUserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<User>(create: (_) => Cars()),
      ],
      child: MaterialApp(
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
                nextScreenPath: LoginScreen.id,
                debug: false,
              ),
        },
      ),
    );
  }
}
