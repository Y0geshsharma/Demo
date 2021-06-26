import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yogesh_sharma/global_function.dart';

class SmallMatchCard extends StatelessWidget {
  const SmallMatchCard({
    this.coverImage,
    this.name,
    this.dateTime,
    this.ticketsSold,
    this.maxTickets,
    this.friendsAttending,
    this.price,
    this.sport,
    this.id,
  });
  final String coverImage;
  final String name;
  final String sport;
  final int id;
  final String dateTime;
  final int ticketsSold;
  final int maxTickets;
  final int friendsAttending;
  final double price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 170,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(coverImage), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.black12,
                  offset: Offset(0, 5.0))
            ]),
        child: Material(
          clipBehavior: Clip.antiAlias,
          type: MaterialType.canvas,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.of(context).pushNamed('/eventDetails',
                  arguments: {'id': id, 'catagory': sport});
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.black26,
            child: Container(
              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              color: Colors.black38,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.schedule,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      Text(
                        convertMicrosecondsToDateTime(dateTime),
                        style: TextStyle(fontSize: 13.0, color: Colors.white),
                      )
                    ],
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(bottom: 24.0, top: 14.0),
                  ),
                  Row(
                    children: [
                      iconChip(
                        iconData: Icons.local_play_sharp,
                        text: '$ticketsSold/$maxTickets',
                        textStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      iconChip(
                        iconData: Icons.card_travel,
                        text: '+$friendsAttending Friends',
                        textStyle: TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      iconChip(
                        bgColor: Colors.cyan,
                        text: "£$price",
                        textStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container iconChip(
      {IconData iconData,
      TextStyle textStyle,
      Color bgColor = Colors.black,
      String text}) {
    return Container(
      constraints: BoxConstraints(minHeight: 26.0),
      margin: EdgeInsets.only(right: 10.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: bgColor == Colors.black
                ? Border.all(color: Colors.white, width: 1.0)
                : Border.all(width: 0),
            borderRadius: BorderRadius.circular(20.0),
            color: bgColor),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconData == null
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        iconData,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
              Container(
                child: Text(
                  text,
                  style: textStyle == null
                      ? TextStyle(color: Colors.white, fontSize: 12.0)
                      : textStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
