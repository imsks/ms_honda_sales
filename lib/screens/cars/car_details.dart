import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ms_honda_sales/screens/cars/get_quote_pdf.dart';
import 'package:ms_honda_sales/services/sharedPrefs.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:ms_honda_sales/components/navbar.dart';
import 'package:ms_honda_sales/models/cars.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';
import 'package:ms_honda_sales/utilities/styles/size_config.dart';
import 'package:ms_honda_sales/services/cars.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
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
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      carDetails[1],
                      style: AppTheme.carDetailsHeaderParamsText,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      carDetails[2],
                      style: AppTheme.carDetailsHeaderParamsText,
                      overflow: TextOverflow.ellipsis,
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

    var addOnNames = Provider.of<CarDetailsProvider>(context).getAddOnNames;
    var addOnValues = Provider.of<CarDetailsProvider>(context).getAddOnValues;

    print(addOnValues);

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
        return data;
      }

      // Set the data getting from DB
      featureValues.add(int.parse(data["exShowRoom"]));
      featureValues.add(int.parse(data["taxCollectedAtSource"]));
      featureValues.add(int.parse(data["insuranceFor1Year"]));
      featureValues.add(int.parse(data["insuranceDifferentsAmountFor2Years"]));
      featureValues.add(int.parse(data["roadTaxAndRegistrationCharges"]));
      featureValues.add(int.parse(data["Fastag"]));
      featureValues.add(int.parse(data["basicAccessoriesKit"]));
      featureValues.add(int.parse(data["extendedWarranty"]));
      featureValues.add(int.parse(data["roadSideAssistance"]));
      featureValues.add(int.parse(data["onRoadPrice"]));
      featureValues.add(int.parse(data["zeroDepPolicy"]));
      featureValues.add(int.parse(data["hydrostaticLockCoverAndKeyCost"]));
      featureValues.add(int.parse(data["returnToInvoice"]));
      featureValues.add(int.parse(data["priceToConnectedDevice"]));
      featureValues.add(int.parse(data["totalOnRoadPriceWithOptionalAddOns"]));
      featureValues
          .add(int.parse(data["oneYearSubscriptionOfConnectedDevices"]));

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
      return data;
    }

    // Generate Dynamic PDF
    _generatePdfAndView(context) async {
      // Get User Details
      SharedPref sharedPref = SharedPref();
      var data = await sharedPref.read("user");
// data["userName"]
      // Defining PDF setup
      final pw.Document pdf = pw.Document(deflate: zlib.encode);
      pdf.addPage(
        pw.MultiPage(
          build: (context) {
            return <pw.Widget>[
              pw.Header(
                level: 0,
                child: pw.Text(
                  "Car Details - " +
                      carDetails[0] +
                      " - " +
                      carDetails[1] +
                      " - " +
                      carDetails[2],
                ),
              ),
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
              // Add-Ons
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  // These will be your columns as Parameter X, Parameter Y etc.
                  <String>[
                    'Add-ons',
                    'Cost',
                  ],
                  for (int i = 0; i < addOnNames.length; i++)
                    <String>[
                      // ith element will go in ith column means
                      // featureNames[i] in 1st column
                      addOnNames[i],
                      // featureValues[i] in 2nd column
                      addOnValues[i].toString(),
                    ],
                ],
              ),
              pw.Footer(
                title: pw.Text(
                  "Quoted by " +
                      data["userName"] +
                      " at " +
                      DateTime.parse(DateTime.now().toString()).day.toString() +
                      " " +
                      DateTime.parse(DateTime.now().toString())
                          .month
                          .toString() +
                      " " +
                      DateTime.parse(DateTime.now().toString()).year.toString(),
                ),
              ),
            ];
          },
        ),
      );

      final fileName = carDetails[0] +
          " - " +
          carDetails[1] +
          " - " +
          carDetails[2] +
          ".pdf";

      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/get_quote_1.pdf';
      final File file = File(path);
      await file.writeAsBytes(pdf.save());
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PdfViewerPage(path: path),
        ),
      );

      await Printing.sharePdf(bytes: pdf.save(), filename: fileName);
    }

    return FutureBuilder(
      future: getACarData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
