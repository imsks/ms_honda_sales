import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ms_honda_sales/models/prospect.dart';
import 'package:ms_honda_sales/screens/cars/get_quote_pdf.dart';
import 'package:ms_honda_sales/screens/cars/prospect_details.dart';
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
import 'package:toast/toast.dart';

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
    var isAddOnsIncluded =
        Provider.of<CarDetailsProvider>(context).getAddOnIncludeStatus;

    var userDetails =
        Provider.of<ProspectDataProvider>(context).getProspectData;

    print(isAddOnsIncluded);

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
      featureValues
          .add(int.parse(data["oneYearSubscriptionOfConnectedDevices"]));
      featureValues.add(int.parse(data["totalOnRoadPriceWithOptionalAddOns"]));

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
        "One Year Subscription Of Connected Devices":
            data["oneYearSubscriptionOfConnectedDevices"],
        "Total On Road Price With Optional Add-Ons":
            data["totalOnRoadPriceWithOptionalAddOns"],
      };
      return data;
    }

    // Generate Dynamic PDF
    _generatePdfAndView(context) async {
      // Get User Details
      SharedPref sharedPref = SharedPref();
      var data = await sharedPref.read("user");

      // Defining PDF setup
      final pw.Document pdf = pw.Document(deflate: zlib.encode);
      pdf.addPage(
        pw.MultiPage(
          build: (context) {
            return <pw.Widget>[
              pw.Container(
                margin: const pw.EdgeInsets.all(15.0),
                padding: const pw.EdgeInsets.all(3.0),
                decoration: pw.BoxDecoration(
                  border: pw.BoxBorder(
                    top: true,
                    color: PdfColors.black,
                  ),
                ),
                child: _contentHeader(context),
              ),
              userDetails.length > 0
                  ? pw.Container(
                      margin: const pw.EdgeInsets.all(15.0),
                      padding: const pw.EdgeInsets.all(3.0),
                      decoration: pw.BoxDecoration(
                        border: pw.BoxBorder(
                          top: true,
                          color: PdfColors.black,
                        ),
                      ),
                      child: _contentUser(
                          context, data["userName"], userDetails[0]["name"]),
                    )
                  : pw.Container(),
              pw.Container(
                margin: const pw.EdgeInsets.all(15.0),
                padding: const pw.EdgeInsets.all(3.0),
                decoration: pw.BoxDecoration(
                  border: pw.BoxBorder(
                    top: true,
                    color: PdfColors.black,
                  ),
                ),
                child: _contentBaseCarDetails(context, carDetails),
              ),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.BoxBorder(
                    top: true,
                    color: PdfColors.black,
                  ),
                ),
                child: _contentMainCarDetails(
                    context, featureNames, featureValues),
              ),
              isAddOnsIncluded
                  ? pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.BoxBorder(
                          top: true,
                          color: PdfColors.black,
                        ),
                      ),
                      child: _contentAddOnCarDetails(
                          context, addOnNames, addOnValues),
                    )
                  : pw.Container(),
              pw.Container(
                margin: const pw.EdgeInsets.all(15.0),
                padding: const pw.EdgeInsets.all(3.0),
                decoration: pw.BoxDecoration(
                  border: pw.BoxBorder(
                    top: true,
                    color: PdfColors.black,
                  ),
                ),
                child: _contentTermsAndConditions(context),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.all(15.0),
                padding: const pw.EdgeInsets.all(3.0),
                decoration: pw.BoxDecoration(
                  border: pw.BoxBorder(
                    top: true,
                    color: PdfColors.black,
                  ),
                ),
                child: _contentRTGSDetails(context),
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

      await Printing.sharePdf(bytes: pdf.save(), filename: fileName);
      CarService carService = new CarService();
      var isQuoteAdded = await carService.sendQuote(
          data["userName"], userDetails, carDetails, isAddOnsIncluded);
      if (isQuoteAdded) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProspectDetails(),
          ),
        );
      }
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

pw.Widget _contentHeader(pw.Context context) {
  return pw.Container(
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "M/S MAANSAROVAR AUTOMOBILE PVT LTD",
            ),
            pw.Text(
              "NO.15 Arcot Road,",
            ),
            pw.Text(
              "Porur, Chennai-600116",
            ),
            pw.Text(
              "Phone Number-044 4942 8920",
            ),
            pw.Text(
              "Mail ID: rfm@maansarovarhonda.in",
            ),
          ],
        ),
        pw.Text(
          "HONDA",
          style: pw.TextStyle(
              color: PdfColors.red,
              fontSize: 50,
              fontWeight: pw.FontWeight.bold),
        )
      ],
    ),
  );
}

pw.Widget _contentUser(pw.Context context, String userName, String prospect) {
  return pw.Container(
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              prospect,
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Quoted By",
            ),
            pw.Text(userName),
          ],
        ),
      ],
    ),
  );
}

pw.Widget _contentBaseCarDetails(pw.Context context, List<String> carDetails) {
  return pw.Container(
    child: pw.RichText(
      text: pw.TextSpan(
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 2 * SizeConfig.textMultiplier,
        ),
        children: [
          pw.TextSpan(
            text: "Proforma Invoice for ",
            style: pw.TextStyle(
              color: PdfColors.black,
            ),
          ),
          pw.TextSpan(
            text: carDetails[0] + " ",
            style: pw.TextStyle(
              color: PdfColors.black,
            ),
          ),
          pw.TextSpan(
            text: carDetails[1] + " ",
            style: pw.TextStyle(
              color: PdfColors.black,
            ),
          ),
          pw.TextSpan(
            text: carDetails[2] + " ",
            style: pw.TextStyle(
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    ),
  );
}

pw.Widget _contentMainCarDetails(
    pw.Context context, List<String> featureNames, List<int> featureValues) {
  return pw.Table.fromTextArray(
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
  );
}

pw.Widget _contentAddOnCarDetails(
    pw.Context context, List<String> featureNames, List<String> featureValues) {
  return pw.Table.fromTextArray(
    context: context,
    data: <List<String>>[
      // These will be your columns as Parameter X, Parameter Y etc.
      <String>[
        'Add On',
        'Cost',
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
  );
}

pw.Widget _contentTermsAndConditions(pw.Context context) {
  return pw.Column(children: [
    pw.Text(
      "Terms And Conditions",
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
    ),
    pw.Text(
      "Payment favouring M/s Maansarovar Automobile Pvt Ltd, through Cheque /Pay Order/ Demand Draft payable at Chennai./ Tentative delivery of vehicle 1 week from the date of receipt of firm Order with full payment / Vehicle specification and Price will be as applicable at the time of Delivery, if whatever discount value mentioned it will be deduct in Ex-showroom price ( Tax Invoice ) only. Cars will be delivered only after realization of cheques /DD/Pay order / Deliveries are subjected to Force Majeure and all disputes are subjected to jurisdiction of Chennai / Cars will be delivered only after registration. The Price ruling at the time of delivery is applicable.",
    ),
  ]);
}

pw.Widget _contentRTGSDetails(pw.Context context) {
  return pw.Column(
    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        "RTGS DETAILS",
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
      ),
      pw.Text(
        "Company Name : Maansarovar Automobile Pvt Ltd",
      ),
      pw.Text(
        "Bank Name : HDFC - Porur Branch",
      ),
      pw.Text(
        "Account Number : 50200013228904",
      ),
      pw.Text(
        "IFSC Code : HDFC0000390",
      ),
      pw.Text(
        "GST No : 33AAMCS5553P1ZO",
      ),
      pw.Text(
        "Tin No : 33806279674",
      ),
    ],
  );
}
