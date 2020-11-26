import 'package:flutter/material.dart';
import 'package:ms_honda_sales/models/cars.dart';
import 'package:ms_honda_sales/screens/cars/car_details.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/components/navbar.dart';
import 'package:provider/provider.dart';

class ChooseCarModel extends StatelessWidget {
  final String carName;
  final List<String> carModels;

  const ChooseCarModel({Key key, this.carName, this.carModels})
      : super(key: key);

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
              CarDetailDropdowns(carModels: carModels),
            ],
          ),
        ),
      ),
    );
  }
}

class CarDetailDropdowns extends StatefulWidget {
  final List<String> carModels;

  const CarDetailDropdowns({Key key, this.carModels}) : super(key: key);

  @override
  _CarDetailDropdownsState createState() => _CarDetailDropdownsState();
}

class _CarDetailDropdownsState extends State<CarDetailDropdowns> {
  void _updateCarDetails(BuildContext context, int index, String carType) {
    Provider.of<CarDetailsProvider>(context, listen: false)
        .updateCarDetails(index, carType);
  }

  @override
  Widget build(BuildContext context) {
    String carType = 'Petrol';
    String carModel = widget.carModels[0];

    var carDetails = Provider.of<CarDetailsProvider>(context).getCarDetails;
    print(carDetails);

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
                  value: carDetails[1],
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
                    _updateCarDetails(context, 1, newValue);
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    print(widget.carModels);
                    setState(() {
                      carModel = newValue;
                    });
                    _updateCarDetails(context, 2, newValue);
                  },
                  items: widget.carModels
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
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarDetails(),
                ),
              )
            },
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
