import 'package:flutter/material.dart';
import 'package:ms_honda_sales/services/sharedPrefs.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';

SharedPref sharedPref = SharedPref();

loadUser() async {
  var user = await sharedPref.read("user");
  return user["userName"];
}

final AppBar globalAppBar = AppBar(
  title: Center(
    child: const Text('MS Honda'),
  ),
  actions: [
    FutureBuilder(
        future: loadUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
              child: Center(
                child: Text(
                  "Hi " + snapshot.data,
                  overflow: TextOverflow.clip,
                ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
              child: Center(
                child: Text("..."),
              ),
            );
          }
        }),
  ],
  backgroundColor: kPrimaryColor,
);
