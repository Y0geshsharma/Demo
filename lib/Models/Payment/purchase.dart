class Purchase {
  String dateTime;
  int id;

  Purchase({this.dateTime, this.id});

  Purchase.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['id'] = this.id;
    return data;
  }
}
