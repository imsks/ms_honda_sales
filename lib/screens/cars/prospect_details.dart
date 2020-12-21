import 'package:flutter/material.dart';
import 'package:ms_honda_sales/components/button.dart';
import 'package:ms_honda_sales/components/input_text_field.dart';
import 'package:ms_honda_sales/models/prospect.dart';
import 'package:ms_honda_sales/screens/cars/dashboard.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProspectDetails extends StatefulWidget {
  @override
  _ProspectDetailsState createState() => _ProspectDetailsState();
}

class _ProspectDetailsState extends State<ProspectDetails> {
  // Define Input Fields
  String name;
  String email;
  String address;

  final loginController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Handle Submit Sign Up
  _addProspectDetails() {
    // TODO: implement initState
    if (_formKey.currentState.validate()) {
      try {
        Provider.of<ProspectDataProvider>(context, listen: false)
            .updateProspectData(
          [
            {
              "name": name,
            },
            {
              "email": email,
            },
            {
              "address": address,
            }
          ],
        );
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: CarsShowcase(),
          ),
        );
      } catch (e) {
        Toast.show(
          e.message,
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  // Screen Variables
  bool isSubmitClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: kWhiteColor,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 5 * SizeConfig.heightMultiplier,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Add Prospect Details",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: kFontFamily,
                          fontSize: 2.5 * SizeConfig.textMultiplier,
                          decoration: TextDecoration.none,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.textMultiplier,
                      ),
                      InputTextField(
                        hintText: "Enter your name",
                        type: TextInputType.name,
                        choice: false,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 1 * SizeConfig.textMultiplier,
                      ),
                      InputTextField(
                        hintText: "Enter your email",
                        type: TextInputType.emailAddress,
                        choice: false,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 1 * SizeConfig.textMultiplier,
                      ),
                      InputTextField(
                        hintText: "Enter your address",
                        type: TextInputType.text,
                        choice: false,
                        onChanged: (value) {
                          setState(() {
                            address = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 4 * SizeConfig.heightMultiplier,
                      ),
                      Button(
                        buttonTextColor: kWhiteColor,
                        minimumWidth: 32 * SizeConfig.heightMultiplier,
                        height: 7 * SizeConfig.heightMultiplier,
                        buttonTextSize: 2.2 * SizeConfig.textMultiplier,
                        buttonTitle: "Add Prospect",
                        onPressed: () async {
                          _addProspectDetails();
                        },
                        buttonColor: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
