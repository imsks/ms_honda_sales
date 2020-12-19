import 'package:flutter/material.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';

class AppTheme {
  //  SplashScreen Styling

  static final TextStyle splashScreenAppName = TextStyle(
    color: kPrimaryColor,
    fontSize: 4 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );
  static final TextStyle splashScreenTagLine = TextStyle(
    color: kPrimaryColor,
    fontSize: 1.8 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  //  DashBoard Styling
  static final TextStyle navBarTitle = TextStyle(
    color: kWhiteColor,
    fontSize: 4 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );

  static final TextStyle dashboardAppName = TextStyle(
    color: kBlackColor,
    fontSize: 3 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle dashboardCarHeading = TextStyle(
    fontSize: 3.5 * SizeConfig.textMultiplier,
    color: kBlackColor,
    fontWeight: FontWeight.w500,
  );

  // Choose Car Model Screen
  static final TextStyle chooseCarModelHeaderHeading = TextStyle(
    fontSize: 3.5 * SizeConfig.textMultiplier,
    color: kPrimaryColor,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle chooseCarModelHeaderSubheading = TextStyle(
    fontSize: 1.5 * SizeConfig.textMultiplier,
    color: kBlackColor,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle carDetailsHeaderParamsText = TextStyle(
    fontSize: 2.5 * SizeConfig.textMultiplier,
    color: kWhiteColor,
    fontWeight: FontWeight.w500,
  );

  //  ActionCard Styling
  static final TextStyle actionCardTime = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 2 * SizeConfig.textMultiplier,
      color: kWhiteColor);
  static final TextStyle actionCardShopName = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 3.5 * SizeConfig.textMultiplier,
    color: kWhiteColor,
  );
  static final TextStyle actionCardShopCategory = TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: 2.8 * SizeConfig.textMultiplier,
      color: Colors.white,
      letterSpacing: 2);
  static final TextStyle actionCardRating = TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: 2.5 * SizeConfig.textMultiplier,
      color: Colors.white,
      letterSpacing: 2);

  //  Add Product Screen Styling
  static final TextStyle imageBoxHeading = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 2.2 * SizeConfig.textMultiplier,
      color: kBlackColor);

  static final InputDecoration inputTextFieldDecoration = InputDecoration(
    errorStyle: TextStyle(fontSize: 2 * SizeConfig.textMultiplier),
    hintStyle: TextStyle(
      color: Colors.black87,
      fontSize: 2.5 * SizeConfig.textMultiplier,
    ),
    hintText: '',
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black87, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black87, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
  );
  static final TextStyle inputTextStyle = TextStyle(
    color: kBlackColor,
    fontSize: 2 * SizeConfig.textMultiplier,
  );
  static final BoxDecoration dropDownBox = BoxDecoration(
    border: Border.all(color: kBlackColor, width: 3.0),
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
  );

  static final TextStyle tagLine = TextStyle(
    color: kBlackColor,
    fontSize: 2 * SizeConfig.heightMultiplier,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );
  static final TextStyle greyText = TextStyle(
      color: Colors.blueGrey,
      fontSize: 3.45 * SizeConfig.textMultiplier,
      fontWeight: FontWeight.bold);

  static final Container tickMark = Container(
    margin: EdgeInsets.only(
      top: 2.76 * SizeConfig.heightMultiplier,
      bottom: 2.76 * SizeConfig.heightMultiplier,
    ),
  );
}
