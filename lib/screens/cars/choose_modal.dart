import 'package:flutter/material.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/components/navbar.dart';

class ChooseCarModel extends StatelessWidget {
  final String carName;

  const ChooseCarModel({Key key, this.carName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar,
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 3 * SizeConfig.heightMultiplier,
            vertical: 2 * SizeConfig.heightMultiplier,
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You're viewing",
                      style: AppTheme.chooseCarModelHeaderSubheading,
                    ),
                    Text(
                      carName,
                      style: AppTheme.chooseCarModelHeaderHeading,
                    ),
                  ],
                ),
              ),
              CarDetailDropdowns(),
            ],
          ),
        ),
      ),
    );
  }
}

class CarDetailDropdowns extends StatefulWidget {
  @override
  _CarDetailDropdownsState createState() => _CarDetailDropdownsState();
}

class _CarDetailDropdownsState extends State<CarDetailDropdowns> {
  String carType = 'Petrol';
  String carModel = 'Model A';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3 * SizeConfig.heightMultiplier,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Column(
              children: [
                Text("Car Type"),
                DropdownButton<String>(
                  value: carType,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      carType = newValue;
                    });
                  },
                  items: <String>['Petrol', 'Diesel']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Column(
              children: [
                Text("Car Model"),
                DropdownButton<String>(
                  value: carModel,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      carModel = newValue;
                    });
                  },
                  items: <String>['Model A', 'Model B', 'Model C', 'Model D']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () => {},
            hoverElevation: 2,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: const Text(
              'View Details',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
