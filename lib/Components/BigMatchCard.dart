import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:yogesh_sharma/global_function.dart';

class BigMatchCard extends StatefulWidget {
  const BigMatchCard({
    this.mainImage,
    this.price,
    this.isPartnered,
    this.sport,
    this.name,
    this.dateTime,
    this.totalPrice,
    this.ticketSold,
    this.maxTicket,
    this.location,
    this.id    
  });
  final String mainImage;
  final double price;
  final bool isPartnered;
  final String sport;
  final String name;
  final String dateTime;
  final int totalPrice;
  final int ticketSold;
  final int maxTicket;
  final String location;
  final int id;

  @override
  _BigMatchCardState createState() => _BigMatchCardState();
}

class _BigMatchCardState extends State<BigMatchCard> {
  bool isLiked = false;
  String hoursBetween(String from) {
    DateTime _from = DateFormat('M/dd/yyyy HH:mm:ss').parse(from);
    DateTime _to = DateTime.now();
    int difference = _to.difference(_from).inHours;
    if (difference > 1) {
      return '$difference hours';
    }
    return '$difference hour';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 30.0,
                offset: Offset(0, 10.0),
                color: Colors.black12)
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pushNamed('/eventDetails',arguments: {'id':widget.id,'catagory':widget.sport});
          },
          child: SizedBox(
            height: 356.0,
            width: 336.0,
            child: Column(
              children: [
                SizedBox(
                  height: 180.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.mainImage))),
                      ),
                      DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                            Colors.transparent,
                            Colors.black54
                          ]))),
                      Container(
                        child: Positioned(
                            bottom: 20.0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 7.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff02d9e7),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      bottomLeft: Radius.circular(50.0))),
                              child: Text(
                                '£${widget.price}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30.0, left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (widget.isPartnered) ...{
                                  simpleTag(
                                    text: "Partnered",
                                  ),
                                },
                                simpleTag(
                                  text: widget.sport,
                                  bg: Colors.white,
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0, bottom: 20.0, right: 70.0),
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22.0),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    Icons.schedule,
                                    color: Colors.white,
                                    size: 17.0,
                                  ),
                                ),
                                Text(
                                  convertMicrosecondsToDateTime(
                                      widget.dateTime),
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total prize:",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "£${widget.totalPrice}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 23.0,
                                icon: Icon(Icons.ios_share),
                                onPressed: () {
                                  Share.share(
                                      "Hey there! This is Tech Alchemy!");
                                },
                              ),
                              IconButton(
                                  iconSize: 23.0,
                                  icon: isLiked
                                      ? Icon(Icons.favorite, color: Colors.red)
                                      : Icon(Icons.favorite_border),
                                  onPressed: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  })
                            ],
                          )
                        ],
                      ),
                      descRow(
                        text1: "Time left to Book:",
                        text2: hoursBetween(widget.dateTime),
                        icon: Icons.av_timer,
                        textStyle: TextStyle(
                          color: Color(0xff0fc6c0),
                        ),
                      ),
                      descRow(
                        text1:
                            "${widget.ticketSold}/${widget.maxTicket} attending total",
                        icon: Icons.local_play_outlined,
                        textStyle: TextStyle(
                            color: Color(0xff7555cf),
                            decoration: TextDecoration.underline),
                      ),
                      descRow(
                          text1: widget.location,
                          text3: "1km",
                          icon: Icons.place_outlined),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Row descRow({
  String text1,
  String text2 = '',
  String text3 = '',
  TextStyle textStyle,
  IconData icon,
}) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Row(children: [
      Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Icon(
          icon,
          size: 20.0,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          width: 169,
          child: Text(
            text1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15.0,
            ).merge(textStyle),
          ),
        ),
      ),
      if (text2?.isNotEmpty) ...{
        Text(
          text2,
          style: TextStyle(
            fontSize: 15.0,
          ),
        )
      }
    ]),
    if (text3?.isNotEmpty) ...{
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Text(text3),
      )
    }
  ]);
}

Padding simpleTag({String text, Color bg}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0, color: Colors.black38, offset: Offset(0, 5.0))
          ],
          color: bg ?? Color(0xff02d9e7),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 12.0,
              color: bg != null ? Colors.black : Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
    ),
  );
}
