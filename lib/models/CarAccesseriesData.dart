class CarAccesseriesData {
  String exShowRoom;
  String taxCollectedAtSource;
  String insuranceFor1Year;
  String insuranceDifferentsAmountFor2Years;
  String roadTaxAndRegistrationCharges;
  String fastag;
  String basicAccessoriesKit;
  String extendedWarranty;
  String roadSideAssistance;
  String onRoadPrice;
  String zeroDepPolicy;
  String hydrostaticLockCoverAndKeyCost;
  String returnToInvoice;
  String priceToConnectedDevice;
  String totalOnRoadPriceWithOptionalAddOns;
  String oneYearSubscriptionOfConnectedDevices;

  CarAccesseriesData(
      this.exShowRoom,
      this.taxCollectedAtSource,
      this.insuranceFor1Year,
      this.insuranceDifferentsAmountFor2Years,
      this.roadTaxAndRegistrationCharges,
      this.fastag,
      this.basicAccessoriesKit,
      this.extendedWarranty,
      this.roadSideAssistance,
      this.onRoadPrice,
      this.zeroDepPolicy,
      this.hydrostaticLockCoverAndKeyCost,
      this.returnToInvoice,
      this.priceToConnectedDevice,
      this.totalOnRoadPriceWithOptionalAddOns,
      this.oneYearSubscriptionOfConnectedDevices);

      CarAccesseriesData.fromJson(Map<String, dynamic> json)
      : exShowRoom = json['exShowRoom'],
      taxCollectedAtSource = json['taxCollectedAtSource'],
      insuranceFor1Year = json['insuranceFor1Year'],
      insuranceDifferentsAmountFor2Years = json['insuranceDifferentsAmountFor2Years'],
      roadTaxAndRegistrationCharges = json['roadTaxAndRegistrationCharges'],
      fastag = json['fastag'],
      basicAccessoriesKit = json['basicAccessoriesKit'],
      extendedWarranty = json['extendedWarranty'],
      roadSideAssistance = json['roadSideAssistance'],
      onRoadPrice = json['onRoadPrice'],
      zeroDepPolicy = json['zeroDepPolicy'],
      hydrostaticLockCoverAndKeyCost = json['hydrostaticLockCoverAndKeyCost'],
      returnToInvoice = json['returnToInvoice'],
      priceToConnectedDevice = json['priceToConnectedDevice'],
      totalOnRoadPriceWithOptionalAddOns = json['totalOnRoadPriceWithOptionalAddOns'],
      oneYearSubscriptionOfConnectedDevices = json['oneYearSubscriptionOfConnectedDevices'];
}
