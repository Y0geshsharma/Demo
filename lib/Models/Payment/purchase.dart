class Purchase {
  String dateTime;
  int purchaseAmount;
  String paymentMethodType;
  int eventId;
  int id;

  Purchase(
      {this.dateTime,
      this.purchaseAmount,
      this.paymentMethodType,
      this.eventId,
      this.id});

  Purchase.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    purchaseAmount = json['purchaseAmount'];
    paymentMethodType = json['paymentMethodType'];
    eventId = json['eventId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['purchaseAmount'] = this.purchaseAmount;
    data['paymentMethodType'] = this.paymentMethodType;
    data['eventId'] = this.eventId;
    data['id'] = this.id;
    return data;
  }
}
