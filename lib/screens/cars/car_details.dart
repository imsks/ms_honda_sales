import 'dart:io';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:ms_honda_sales/components/navbar.dart';
import 'package:ms_honda_sales/models/cars.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/services/cars.dart';
import 'package:pdf/widgets.dart' as pw;

class CarDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var carDetails = Provider.of<CarDetailsProvider>(context).getCarDetails;

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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
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
            ],
          ),
        ),
      ),
    );
  }
}

class CarAccesseries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get Data from DB
    CarService carService = CarService();

    var carDetails = Provider.of<CarDetailsProvider>(context).getCarDetails;

    // Define Data map
    var dataMap = Map();

    // Feature Names
    final List<String> featureNames = <String>[
      'Ex Show Room',
      'Tax Collected At Source',
      'Insurance For 1 Year',
      'Insurance Differents Amount For 2 Years',
      'Road Tax And Registration Charges',
      'Fastag',
      'Basic Accessories Kit',
      'Extended Warranty',
      'Road Side Assistance',
      'On Road Price',
      'Zero Dep Policy',
      'Hydrostatic Lock Cover And Key Cost',
      'Return To Invoice',
      'Price To Connected Device',
      'Total On Road Price With Optional Add-Ons',
      'One Year Subscription Of Connected Devices',
    ];

    // Feature Values
    final List<int> featureValues = <int>[];

    getACarData() async {
      final data = await carService.getACarData(
          carDetails[0], carDetails[2], carDetails[1]);

      // If Error
      if (data["message"] != null) {
        print(data);
        return data;
      }

      // Set the data getting from DB
      featureValues.add(data["exShowRoom"]);
      featureValues.add(data["taxCollectedAtSource"]);
      featureValues.add(data["insuranceFor1Year"]);
      featureValues.add(data["insuranceDifferentsAmountFor2Years"]);
      featureValues.add(data["roadTaxAndRegistrationCharges"]);
      featureValues.add(data["fastag"]);
      featureValues.add(data["basicAccessoriesKit"]);
      featureValues.add(data["extendedWarranty"]);
      featureValues.add(data["roadSideAssistance"]);
      featureValues.add(data["onRoadPrice"]);
      featureValues.add(data["zeroDepPolicy"]);
      featureValues.add(data["hydrostaticLockCoverAndKeyCost"]);
      featureValues.add(data["returnToInvoice"]);
      featureValues.add(data["priceToConnectedDevice"]);
      featureValues.add(data["totalOnRoadPriceWithOptionalAddOns"]);
      featureValues.add(data["oneYearSubscriptionOfConnectedDevices"]);

      // Data Map
      dataMap = {
        "Ex Show Room": data["exShowRoom"],
        "Tax Collected At Source": data["taxCollectedAtSource"],
        "Insurance For 1 Year": data["insuranceFor1Year"],
        "Insurance Differents Amount For 2 Years":
            data["insuranceDifferentsAmountFor2Years"],
        "Road Tax And Registration Charges":
            data["roadTaxAndRegistrationCharges"],
        "Fastag": data["fastag"],
        "Basic Accessories Kit": data["basicAccessoriesKit"],
        "Extended Warranty": data["extendedWarranty"],
        "Road Side Assistance": data["roadSideAssistance"],
        "Zero Dep Policy": data["zeroDepPolicy"],
        "Hydrostatic Lock Cover And Key Cost":
            data["hydrostaticLockCoverAndKeyCost"],
        "Return To Invoice": data["exShowRoom"],
        "Price To Connected Device": data["returnToInvoice"],
        "Total On Road Price With Optional Add-Ons":
            data["totalOnRoadPriceWithOptionalAddOns"],
        "One Year Subscription Of Connected Devices":
            data["oneYearSubscriptionOfConnectedDevices"],
      };
      print(dataMap);
      return data;
    }

    // Generate Dynamic PDF
    _generatePdfAndView(context) async {
      final pw.Document pdf = pw.Document(deflate: zlib.encode);
      pdf.addPage(
        pw.MultiPage(
          build: (context) {
            return <pw.Widget>[
              pw.Header(
                  level: 0,
                  child: pw.Text("Car Details - " +
                      carDetails[0] +
                      " - " +
                      carDetails[1] +
                      " - " +
                      carDetails[2])),
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  // These will be your columns as Parameter X, Parameter Y etc.
                  <String>[
                    'Parameter',
                    'Price',
                  ],
                  for (int i = 0; i < featureNames.length; i++)
                    <String>[
                      // ith element will go in ith column means
                      // featureNames[i] in 1st column
                      featureNames[i],
                      // featureValues[i] in 2nd column
                      featureValues[i].toString(),
                    ],
                ],
              ),
            ];
          },
        ),
      );

      final fileName =
          carDetails[0] + " - " + carDetails[1] + " - " + carDetails[2] + ".pdf";

      await Printing.sharePdf(bytes: pdf.save(), filename: fileName);
    }

    return FutureBuilder(
      future: getACarData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data["message"]);
          if (snapshot.data["message"] == null) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              child: Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    // padding: const EdgeInsets.all(4),
                    itemCount: featureNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.grey[200],
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                padding: new EdgeInsets.only(right: 15.0),
                                child: Text(
                                  featureNames[index],
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                            Text(
                              featureValues[index].toString(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  RaisedButton(
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textColor: Colors.white,
                    onPressed: () async {
                      _generatePdfAndView(context);
                    },
                    child: Text(
                      "Get Quote",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("No data exists"),
              ),
            );
          }
        } else {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("Loading"),
            ),
          );
        }
      },
    );
  }
}
