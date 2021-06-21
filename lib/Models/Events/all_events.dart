import 'package:equatable/equatable.dart';

class AllEvents extends Equatable {
  String name;
  String dateTime;
  String bookBy;
  int ticketsSold;
  int maxTickets;
  int friendsAttending;
  double price;
  bool isPartnered;
  String sport;
  int totalPrize;
  String location;
  bool isRecommended;
  String mainImage;
  int id;

  AllEvents(
      {this.name,
      this.dateTime,
      this.bookBy,
      this.ticketsSold,
      this.maxTickets,
      this.friendsAttending,
      this.price,
      this.isPartnered,
      this.sport,
      this.totalPrize,
      this.location,
      this.isRecommended,
      this.mainImage,
      this.id});

  AllEvents.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    bookBy = json['bookBy'];
    ticketsSold = json['ticketsSold'];
    maxTickets = json['maxTickets'];
    friendsAttending = json['friendsAttending'];
    price = double.tryParse(json['price'].toString())??0.0;
    isPartnered = json['isPartnered'];
    sport = json['sport'];
    totalPrize = json['totalPrize'];
    location = json['location'];
    isRecommended = json['isRecommended'];
    mainImage = json['mainImage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dateTime'] = this.dateTime;
    data['bookBy'] = this.bookBy;
    data['ticketsSold'] = this.ticketsSold;
    data['maxTickets'] = this.maxTickets;
    data['friendsAttending'] = this.friendsAttending;
    data['price'] = this.price;
    data['isPartnered'] = this.isPartnered;
    data['sport'] = this.sport;
    data['totalPrize'] = this.totalPrize;
    data['location'] = this.location;
    data['isRecommended'] = this.isRecommended;
    data['mainImage'] = this.mainImage;
    data['id'] = this.id;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        name,
        dateTime,
        bookBy,
        ticketsSold,
        maxTickets,
        friendsAttending,
        price,
        isPartnered,
        sport,
        totalPrize,
        location,
        isRecommended,
        mainImage,
        id,
      ];
}
