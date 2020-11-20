import 'package:flutter/material.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';

class CarsShowcase extends StatelessWidget {
  static const String id = 'carshowcase';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('MS Honda')),
        backgroundColor: kBlackColor,
      ),
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
          vertical: 3 * SizeConfig.heightMultiplier,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text("View Car Models", style: AppTheme.dashboardAppName),
            ),
            CarList(),
            Card(
              child: InkWell(
                splashColor: kCardBackgroundColor,
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 50 * SizeConfig.heightMultiplier,
                  height: 20 * SizeConfig.heightMultiplier,
                  child: Text('A card that can be tapped'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: kCardBackgroundColor,
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 50 * SizeConfig.heightMultiplier,
                  height: 20 * SizeConfig.heightMultiplier,
                  child: Text('A card that can be tapped'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarList extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          // return Container(
          //   height: 50,
          //   color: Colors.amber[colorCodes[index]],
          //   child: Center(child: Text('Entry ${entries[index]}')),
          // );
          return Card(
            child: InkWell(
              splashColor: kCardBackgroundColor,
              onTap: () {
                print('Card tapped.');
              },
              child: Container(
                width: 50 * SizeConfig.heightMultiplier,
                height: 20 * SizeConfig.heightMultiplier,
                child: Text('A card that can be tapped'),
              ),
            ),
          );
        });
  }
}
