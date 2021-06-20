import 'package:equatable/equatable.dart';

class Purchase extends Equatable {
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

  @override
  List<Object> get props => [dateTime, id];
}
