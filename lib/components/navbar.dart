import 'package:flutter/material.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'VireStore',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: kBlackColor,
            ),
          ),
          ListTile(
            title: GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => YourOrders(),
              //     ),
              //   );
              // },
              child: Text(
                'Your Orders',
                style: TextStyle(fontSize: 18),
              ),
            ),
            onTap: () {
              print("tapped");
            },
          ),
          ListTile(
            title: Text(
              'Track Order',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Sign out',
              style: TextStyle(fontSize: 18),
            ),
            // onTap: () {
            //   Navigator.pop(context);
            //   showDialog(
            //       context: context,
            //       builder: (BuildContext context) => signOutPopup(context));
            // },
          ),
        ],
      ),
    );
  }
}
