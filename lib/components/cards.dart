import 'package:flutter/material.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    @required this.travelTime,
    @required this.shopName,
    @required this.shopCategory,
    @required this.rating,
  });
  final double travelTime;
  final String shopName;
  final String shopCategory;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170 * SizeConfig.heightMultiplier,
      height: 30 * SizeConfig.heightMultiplier,
      child: Card(
        color: kBlackColor,
        elevation: 3,
        semanticContainer: true,
        margin: EdgeInsets.all(
          0.7 * SizeConfig.heightMultiplier,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                2.76 * SizeConfig.heightMultiplier,
                4 * SizeConfig.heightMultiplier,
                2.76 * SizeConfig.heightMultiplier,
                0,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    travelTime.round().toString() + ' Min Away',
                    style: AppTheme.actionCardTime,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 22 * SizeConfig.heightMultiplier,
                        bottom: 1.5 * SizeConfig.heightMultiplier),
                    child: Icon(
                      Icons.star_border,
                      color: Colors.white70,
                      size: 2.2 * SizeConfig.textMultiplier,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                2.76 * SizeConfig.heightMultiplier,
                0,
                2.76 * SizeConfig.heightMultiplier,
                0,
              ),
              child: Text(
                (shopName.toString().length > 25)
                    ? shopName.substring(0, 25) + '...'
                    : shopName,
                style: AppTheme.actionCardShopName,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                2.76 * SizeConfig.heightMultiplier,
                1.5 * SizeConfig.heightMultiplier,
                2.76 * SizeConfig.heightMultiplier,
                0,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    shopCategory,
                    style: AppTheme.actionCardShopCategory,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 8 * SizeConfig.heightMultiplier),
                    child: Text(
                      rating.toString(),
                      style: AppTheme.actionCardRating,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
