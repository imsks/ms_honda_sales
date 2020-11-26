import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ms_honda_sales/components/navbar.dart';
import 'package:ms_honda_sales/models/cars.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/services/cars.dart';

class CarDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CarService carService = CarService();

    var carDetails = Provider.of<CarDetailsProvider>(context).getCarDetails;

    List<String> carAccessories = [];

    getACarData() async {
      final temp = await carService.getACarData(
          carDetails[0], carDetails[2], carDetails[1]);

      carAccessories = temp;
      // print(temp);

      // // Set Parameters
      // exShowRoom = temp["exShowRoom"];
      // taxCollectedAtSource = temp["taxCollectedAtSource"];
      // insuranceFor1Year = temp["insuranceFor1Year"];
      // insuranceDifferentsAmountFor2Years =
      //     temp["insuranceDifferentsAmountFor2Years"];
      // roadTaxAndRegistrationCharges = temp["roadTaxAndRegistrationCharges"];
      // fastag = temp["fastag"];
      // basicAccessoriesKit = temp["basicAccessoriesKit"];
      // extendedWarranty = temp["extendedWarranty"];
      // roadSideAssistance = temp["roadSideAssistance"];
      // onRoadPrice = temp["onRoadPrice"];
      // zeroDepPolicy = temp["zeroDepPolicy"];
      // hydrostaticLockCoverAndKeyCost = temp["hydrostaticLockCoverAndKeyCost"];
      // returnToInvoice = temp["returnToInvoice"];
      // priceToConnectedDevice = temp["priceToConnectedDevice"];
      // totalOnRoadPriceWithOptionalAddOns =
      //     temp["totalOnRoadPriceWithOptionalAddOns"];
      // oneYearSubscriptionOfConnectedDevices =
      //     temp["oneYearSubscriptionOfConnectedDevices"];

      return temp;
    }

    return Scaffold(
      appBar: globalAppBar,
      backgroundColor: kBackgroundColor,
      body: FutureBuilder(
        future: getACarData(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.hasData) {
              print(snapshot.data);
              print("S");
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3 * SizeConfig.heightMultiplier,
                    vertical: 2 * SizeConfig.heightMultiplier,
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                        color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(
                              carDetails[0],
                              style: AppTheme.carDetailsHeaderParamsText,
                            ),
                            Text(
                              carDetails[1],
                              style: AppTheme.carDetailsHeaderParamsText,
                            ),
                            Text(
                              carDetails[2],
                              style: AppTheme.carDetailsHeaderParamsText,
                            ),
                          ],
                        ),
                      ),
                      CarAccesseries(),
                      Container(
                        child: RaisedButton(
                          color: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textColor: Colors.white,
                          onPressed: () => {},
                          child: Text(
                            "Get Quote",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              Container(
                child: Text("Not Loaded"),
              );
            }
          } else {
            return Container(
              child: Text("No data"),
            );
          }
        },
      ),
    );
  }
}

class CarAccesseries extends StatelessWidget {
  // Define Accesseries
    String exShowRoom = '';
    String taxCollectedAtSource = '';
    String insuranceFor1Year = '';
    String insuranceDifferentsAmountFor2Years = '';
    String roadTaxAndRegistrationCharges = '';
    String fastag = '';
    String basicAccessoriesKit = '';
    String extendedWarranty = '';
    String roadSideAssistance = '';
    String onRoadPrice = '';
    String zeroDepPolicy = '';
    String hydrostaticLockCoverAndKeyCost = '';
    String returnToInvoice = '';
    String priceToConnectedDevice = '';
    String totalOnRoadPriceWithOptionalAddOns = '';
    String oneYearSubscriptionOfConnectedDevices = '';
    
  final List<String> featureNames = <String>[
    'Feature 1',
    'Feature 2',
    'Feature 3',
    'Feature 4',
    'Feature 5',
    'Feature 6',
    'Feature 7',
    'Feature 8',
    'Feature 9',
    'Feature 10',
    'Feature 11',
    'Feature 12',
    'Feature 13',
    'Feature 14',
    'Feature 15',
    'Feature 16',
  ];

  final List<String> featureValues = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        // padding: const EdgeInsets.all(4),
        itemCount: featureNames.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  featureNames[index],
                ),
                Text(
                  featureValues[index],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
