import 'package:flutter/material.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/components/navbar.dart';
import 'package:ms_honda_sales/screens/cars/choose_modal.dart';

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
  final List<String> carNames = <String>[
    'Amaze 1',
    'Amaze 2',
    'Amaze 3',
    'Amaze 4'
  ];
  final List<String> carPhotos = <String>[
    'https://imgd.aeplcdn.com/0x0/n/cw/ec/33276/amaze-exterior-right-front-three-quarter.jpeg',
    'https://imgd.aeplcdn.com/0x0/n/cw/ec/33276/amaze-exterior-right-front-three-quarter.jpeg',
    'https://imgd.aeplcdn.com/0x0/n/cw/ec/33276/amaze-exterior-right-front-three-quarter.jpeg',
    'https://imgd.aeplcdn.com/0x0/n/cw/ec/33276/amaze-exterior-right-front-three-quarter.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                // print(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChooseCarModel(carName: carNames[index]),
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
        });
  }
}
