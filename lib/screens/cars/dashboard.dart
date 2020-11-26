import 'package:flutter/material.dart';
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

  final List<String> carPhotos = <String>[
    'https://imgd.aeplcdn.com/0x0/n/cw/ec/33276/amaze-exterior-right-front-three-quarter.jpeg',
    'https://imgd.aeplcdn.com/0x0/n/cw/ec/33276/amaze-exterior-right-front-three-quarter.jpeg',
    'https://imgd.aeplcdn.com/0x0/n/cw/ec/33276/amaze-exterior-right-front-three-quarter.jpeg',
  ];

  CarService carService = CarService();

  getAllCarsData() async {
    final temp = await carService.getAllCarsData();
    // print(temp[0]);
    // print(temp[0]["data"]["carData"]["modelNo"]);

    for (int i = 0; i < temp.length - 1; i++) {
      // Set Car Names
      if (carNames.indexOf(temp[i]["data"]["carData"]["carName"]) == -1)
        carNames.add(temp[i]["data"]["carData"]["carName"]);
      // Set Car Models
      if (carModels.indexOf(temp[i]["data"]["carData"]["modelNo"]) == -1)
        carModels.add(temp[i]["data"]["carData"]["modelNo"]);
    }
    // print(carModels);

    return temp;
  }

  void _updateCarDetails(BuildContext context, int index, String carName) {
    Provider.of<CarDetailsProvider>(context, listen: false)
        .updateCarDetails(index, carName);
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
                            MaterialPageRoute(
                              builder: (context) => ChooseCarModel(
                                carName: carNames[index],
                                carModels: carModels,
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
                                carPhotos[index],
                                height: 25 * SizeConfig.heightMultiplier,
                                // width: double.infinity,
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
                child: Text("Not Loaded"),
              );
            }
          },
        ),
      ],
    );
  }
}
