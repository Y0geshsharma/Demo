class CheckOut {
  String name;
  String dateTime;
  int price;
  bool isPrivate;
  String location;
  String gameLength;
  String paymentMethodUnsupported;
  String mainImage;
  int id;

  CheckOut(
      {this.name,
      this.dateTime,
      this.price,
      this.isPrivate,
      this.location,
      this.gameLength,
      this.paymentMethodUnsupported,
      this.mainImage,
      this.id});

  CheckOut.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    price = json['price'];
    isPrivate = json['isPrivate'];
    location = json['location'];
    gameLength = json['gameLength'];
    paymentMethodUnsupported = json['paymentMethodUnsupported'];
    mainImage = json['mainImage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dateTime'] = this.dateTime;
    data['price'] = this.price;
    data['isPrivate'] = this.isPrivate;
    data['location'] = this.location;
    data['gameLength'] = this.gameLength;
    data['paymentMethodUnsupported'] = this.paymentMethodUnsupported;
    data['mainImage'] = this.mainImage;
    data['id'] = this.id;
    return data;
  }
}
