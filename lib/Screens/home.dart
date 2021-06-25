import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogesh_sharma/Components/BigMatchCard.dart';
import 'package:yogesh_sharma/Components/SmallMatchCard.dart';
import 'package:yogesh_sharma/Components/bottom_nav.dart';
import 'package:yogesh_sharma/Models/Events/all_events.dart';
import 'package:yogesh_sharma/bloc/Events/all_events_bloc.dart';
import 'package:yogesh_sharma/bloc/Events/all_events_state.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllEventBloc, AllEventsState>(
        builder: (context, state) {
          if (state is AllEventsStateLoadInProgress ||
              state is AllEventsStateInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AllEventsStateLoadSuccess) {
            return homeScreen(context, state.allEvents);
          }
          return SizedBox();
        },
      ),
    );
  }

  Material homeScreen(BuildContext context, List<AllEvents> eventList) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Color(0xFFF9F6F6),
        child: Stack(
          alignment: Alignment.center,
          children: [
            feedDrawer(context, eventList),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: topInputBar(context),
            ),
            Positioned(
                bottom: 80.0,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  elevation: 10.0,
                  color: Theme.of(context).accentColor,
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        "Add Event",
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15.0,
                        ),
                      )
                    ],
                  ),
                )),
            Positioned(bottom: 0, right: 0, left: 0, child: BottomNav()),
          ],
        ),
      ),
    );
  }

  Container topInputBar(context) {
    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: [
            BoxShadow(
                blurRadius: 20.0,
                color: Theme.of(context).accentColor.withOpacity(0.7),
                offset: Offset(0, 10.0))
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0))),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0)
          .add(EdgeInsets.only(top: 30.0)),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.none,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  child: Stack(
                    children: [
                      IconButton(
                          splashColor: Colors.red,
                          color: Colors.white,
                          icon: Icon(Icons.notifications_none_sharp),
                          onPressed: () {}),
                      Positioned(
                        right: 8.0,
                        top: 0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.black38,
                                    offset: Offset(0, 2.0))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "3",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0)
                        .copyWith(left: 15.0),
                    margin: EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                        color: Color(0x20ffffff),
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextField(
                          autofocus: false,
                          cursorWidth: 1.0,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                              hintText: "Search by Event, code, location",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3))),
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        )),
                        IconButton(
                          icon: Icon(Icons.tune),
                          onPressed: () {},
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Positioned feedDrawer(BuildContext context, List<AllEvents> events) {
    return Positioned(
      top: 150.0,
      right: 0,
      left: 0,
      bottom: 0,
      child: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              listHeading(context, "Recommended Events"),
              Container(
                height: 170.0,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: events.length,
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      AllEvents currentEvent = events[index];
                      if (currentEvent.isRecommended) {
                        return Container(
                            margin: EdgeInsets.only(right: 20.0),
                            alignment: Alignment.topLeft,
                            child: SmallMatchCard(
                              coverImage: currentEvent.mainImage,
                              dateTime: currentEvent.dateTime,
                              maxTickets: currentEvent.maxTickets,
                              ticketsSold: currentEvent.ticketsSold,
                              friendsAttending: currentEvent.friendsAttending,
                              price: currentEvent.price,
                              name: currentEvent.name,
                              id: currentEvent.id,
                            ));
                      }
                      return const SizedBox();
                    }),
              ),
            ],
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.40,
          minChildSize: 0.40,
          builder: (BuildContext ctx, ScrollController controller) =>
              SingleChildScrollView(
                  controller: controller, child: matchFeed(context, events)),
        ),
      ]),
    );
  }

  Container matchFeed(BuildContext context, List<AllEvents> events) {
    return Container(
      padding: EdgeInsets.only(bottom: 100.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Column(
            children: [
              listHeading(context, "All Events"),
              for (AllEvents event in events) ...{
                BigMatchCard(
                  name: event.name,
                  dateTime: event.dateTime,
                  location: event.location,
                  isPartnered: event.isPartnered,
                  sport: event.sport,
                  mainImage: event.mainImage,
                  maxTicket: event.maxTickets,
                  ticketSold: event.ticketsSold,
                  totalPrice: event.totalPrize,
                  price: event.price,
                  id: event.id,
                ),
              },
            ],
          )
        ],
      ),
    );
  }

  Container listHeading(BuildContext context, String title) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0)
            .add(EdgeInsets.only(top: 20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'View all',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xffE77460)),
                ))
          ],
        ),
      ),
    );
  }
}
