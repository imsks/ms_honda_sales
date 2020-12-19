import 'package:flutter/material.dart';
import 'package:ms_honda_sales/models/cars.dart';
import 'package:ms_honda_sales/models/prospect.dart';
import 'package:ms_honda_sales/screens/cars/car_details.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/components/navbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ChooseCarModel extends StatelessWidget {
  final String carName;
  final List<String> carModels;
  final List<Map<String, dynamic>> addOnsData;

  const ChooseCarModel({Key key, this.carName, this.carModels, this.addOnsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map addOnData = Map<String, dynamic>();
    addOnsData.forEach((element) {
      if (element[carName] != null) {
        addOnData = element[carName];
      }
    });

    // Define list for Name and values of add-ons
    List<String> addOnNames = <String>[];
    List<String> addOnValues = <String>[];

    addOnData.forEach((key, value) {
      addOnNames.add(value["addOnName"]);
      addOnValues.add(value["addOnValue"]);
    });

    return Scaffold(
      appBar: globalAppBar,
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 3 * SizeConfig.heightMultiplier,
            vertical: 5 * SizeConfig.heightMultiplier,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 3 * SizeConfig.heightMultiplier, vertical: 8),
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
              CarDetailDropdowns(
                carModels: carModels,
                addOnNames: addOnNames,
                addOnValues: addOnValues,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarDetailDropdowns extends StatefulWidget {
  final List<String> carModels;

  final List<String> addOnNames;
  final List<String> addOnValues;

  const CarDetailDropdowns(
      {Key key, this.carModels, this.addOnNames, this.addOnValues})
      : super(key: key);

  @override
  _CarDetailDropdownsState createState() => _CarDetailDropdownsState();
}

class _CarDetailDropdownsState extends State<CarDetailDropdowns> {
  void _updateCarDetails(BuildContext context, int index, String carType) {
    Provider.of<CarDetailsProvider>(context, listen: false)
        .updateCarDetails(index, carType);
  }

  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    String carType = '';
    String carModel = '';

    var carDetails = Provider.of<CarDetailsProvider>(context).getCarDetails;

    void _setAddOnData() {
      Provider.of<CarDetailsProvider>(context, listen: false)
          .setAddOnName(widget.addOnNames);
      Provider.of<CarDetailsProvider>(context, listen: false)
          .setAddOnValue(widget.addOnValues);
      Provider.of<CarDetailsProvider>(context, listen: false)
          .setAddOnIncludedStatus(checkedValue);

      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CarDetails(),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3 * SizeConfig.heightMultiplier,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Car Type"),
                DropdownButton<String>(
                  isExpanded: true,
                  value: carDetails[1],
                  itemHeight: 50,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  iconSize: 24,
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
            padding: EdgeInsets.symmetric(
                horizontal: 3 * SizeConfig.heightMultiplier, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Car Model"),
                DropdownButton<String>(
                  isExpanded: true,
                  itemHeight: 50,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  value: carDetails[2],
                  iconSize: 24,
                  onChanged: (String newValue) {
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
          SizedBox(
            height: 2 * SizeConfig.heightMultiplier,
          ),
          widget.addOnNames.length > 0
              ? CheckboxListTile(
                  title: Text("Include Add-ons"),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                )
              : Center(
                child: Container(
                  child: Text(
                    "No add-ons available"
                  ),
                ),
              ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.addOnNames.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                margin: EdgeInsets.symmetric(
                  // horizontal: 3 * SizeConfig.heightMultiplier,
                  vertical: 1 * SizeConfig.heightMultiplier,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 3 * SizeConfig.heightMultiplier,
                  vertical: 2 * SizeConfig.heightMultiplier,
                ),
                color: kWhiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.addOnNames[index],
                      style: TextStyle(
                        fontSize: 2.5 * SizeConfig.textMultiplier,
                      ),
                    ),
                    Text(
                      widget.addOnValues[index],
                      style: TextStyle(
                        fontSize: 2.5 * SizeConfig.textMultiplier,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 3 * SizeConfig.heightMultiplier,
          ),
          Center(
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.black,
              focusElevation: 0,
              hoverElevation: 0,
              onPressed: () => {
                _setAddOnData(),
              },
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 15,
              ),
              child: const Text(
                'View Details',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
