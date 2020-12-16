import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:ms_honda_sales/models/cars.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/components/navbar.dart';
import 'package:ms_honda_sales/screens/cars/choose_modal.dart';
import 'package:ms_honda_sales/services/cars.dart';

class CarsShowcase extends StatelessWidget {
  static const String id = 'carshowcase';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar,
      body: ShowcaseContainer(),
      backgroundColor: kBackgroundColor,
    );
  }
}

class ShowcaseContainer extends StatelessWidget {
  ShowcaseContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3 * SizeConfig.heightMultiplier,
          vertical: 1 * SizeConfig.heightMultiplier,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text("View Car Models", style: AppTheme.dashboardAppName),
            ),
            CarList(),
          ],
        ),
      ),
    );
  }
}

class CarList extends StatelessWidget {
  // Define the car data
  // 1. Store Car IDs
  final List<String> carIDs = <String>[];

  // 2. Store Car Names
  final List<String> carNames = <String>[];

  // 3. Store Car Models
  final List<String> carModels = <String>[];

  // 4. Store Car Type
  final List<String> carTypes = <String>[];

  // 5. Store car images
  final List<String> carImages = <String>[];

  // 6. Store car add-ons
  List<Map<String, dynamic>> addOnsData = List<Map<String, dynamic>>();

  CarService carService = CarService();

  getAllCarsData() async {
    final carsData = await carService.getAllCarsData();

    for (int i = 0; i < carsData.length; i++) {
      // Set Car Addons
      if (carsData[i]["data"]["carData"]["addOnsData"] != null &&
          carsData[i]["data"]["carData"]["carName"] != null) {
        addOnsData.add({
          carsData[i]["data"]["carData"]["carName"]: carsData[i]["data"]
              ["carData"]["addOnsData"],
        });
      }

      // Set Car Names
      if (carNames.indexOf(carsData[i]["data"]["carData"]["carName"]) == -1)
        carNames.add(carsData[i]["data"]["carData"]["carName"]);
      // Set Car Models
      if (carModels.indexOf(carsData[i]["data"]["carData"]["modelNo"]) == -1)
        carModels.add(carsData[i]["data"]["carData"]["modelNo"]);

      if (carsData[i]["data"]["carData"]["carImage"] != null) {
        carImages.add(carsData[i]["data"]["carData"]["carImage"]);
      } else {
        carImages.add(
            'https://imgd.aeplcdn.com/0x0/n/cw/ec/33276/amaze-exterior-right-front-three-quarter.jpeg');
      }
    }
    return carsData;
  }

  void _updateCarDetails(BuildContext context, int index, String carParameter) {
    Provider.of<CarDetailsProvider>(context, listen: false)
        .updateCarDetails(index, carParameter);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: getAllCarsData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(4),
                  itemCount: carNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: InkWell(
                        splashColor: kCardBackgroundColor,
                        onTap: () {
                          _updateCarDetails(context, 0, carNames[index]);
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ChooseCarModel(
                                carName: carNames[index],
                                carModels: carModels,
                                addOnsData: addOnsData,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          // width: 50 * SizeConfig.heightMultiplier,
                          height: 35 * SizeConfig.heightMultiplier,
                          child: Column(
                            children: [
                              Image.network(
                                carImages[index],
                                height: 25 * SizeConfig.heightMultiplier,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                height: 10 * SizeConfig.heightMultiplier,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                child: Center(
                                  child: Text(carNames[index],
                                      style: AppTheme.dashboardCarHeading),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text("Not Loaded"),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
