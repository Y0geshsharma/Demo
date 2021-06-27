import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:yogesh_sharma/Components/BigMatchCard.dart';
import 'package:yogesh_sharma/Components/LoaderPage.dart';
import 'package:yogesh_sharma/Constants/app_text.dart';
import 'package:yogesh_sharma/Constants/endpoints.dart';
import 'package:yogesh_sharma/Models/Events/all_events.dart';
import 'package:yogesh_sharma/Models/Events/event_details.dart';
import 'package:yogesh_sharma/bloc/EventDetails/details_bloc.dart';
import 'package:yogesh_sharma/bloc/EventDetails/details_state.dart';
import 'package:yogesh_sharma/bloc/Events/all_events_bloc.dart';
import 'package:yogesh_sharma/bloc/Events/all_events_state.dart';
import 'package:yogesh_sharma/global_function.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailScreen extends StatefulWidget {
  EventDetailScreen();

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xFF1A0451).withOpacity(0.4),
          toolbarHeight: 70,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(Icons.ios_share),
              onPressed: () {
                Share.share("Hey there! This is Tech Alchemy!");
              },
            )
          ],
        ),
        body: BlocBuilder<EventDetailsBloc, EventDetailsState>(
            builder: (context, state) {
          if (state is EventDetailsStateInitial ||
              state is EventDetailsStateLoadInProgress) {
            return Center(
              child: LoaderPage(),
            );
          }
          if (state is EventDetailsStateLoadSuccess) {
            return eventDetails(context, state.eventDetails);
          }

          return SizedBox();
        }));
  }

  SingleChildScrollView eventDetails(
      BuildContext context, EventDetails eventDetails) {
    List<String> formatAboutText() {
      var splittedText = eventDetails.description.toString().split(' ');
      var firstPart = '';
      var secondPart = '';
      for (int i = 0; i < splittedText.length; i++) {
        if (i < (splittedText.length / 2).floor()) {
          firstPart += ' ' + splittedText[i];
        }

        if (i >= (splittedText.length / 2).floor()) {
          secondPart += ' ' + splittedText[i];
        }
      }
      return [firstPart, secondPart];
    }

    var tagList = eventDetails.tags.split('"');
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 386.0,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                  height: 386,
                  child: ParallaxImage(imageUrl: eventDetails.mainImage)),
              DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54]))),
              Container(
                child: Positioned(
                    bottom: 20.0,
                    right: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                      decoration: BoxDecoration(
                          color: Color(0xff02d9e7),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              bottomLeft: Radius.circular(50.0))),
                      child: Text(
                        '£${eventDetails.price}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (eventDetails.isPartnered) ...{
                            simpleTag(
                              text: "Partnered",
                            ),
                          },
                          simpleTag(
                            text: eventDetails.sport,
                            bg: Colors.white,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 20.0, right: 70.0),
                        child: Text(
                          eventDetails.name,
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
                                eventDetails.dateTime),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
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
                        "£${eventDetails.totalPrize}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      (ElevatedButton.icon(
                        onPressed: () {
                          Share.share("Hey there! This is Tech Alchemy!");
                        },
                        icon: Icon(
                          Icons.person_add_alt,
                          size: 15.0,
                        ),
                        label: Text(
                          'Share Event',
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: Color(0xFF9DA6B1),
                            minimumSize: Size(119.0, 27),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            textStyle: TextStyle(fontSize: 12)),
                      )),
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
                text1:
                    "${eventDetails.ticketsSold}/${eventDetails.maxTickets} attending total",
                icon: Icons.local_play_outlined,
                textStyle: TextStyle(
                    color: Color(0xff7555cf),
                    decoration: TextDecoration.underline),
              ),
              const SizedBox(height: 19),
              Row(
                children: [
                  for (int i = 0; i < tagList.length; i++) ...{
                    if (i % 2 != 0) ...{
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 24,
                        decoration: BoxDecoration(
                          color: Color(0xFFFDF7F8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '#${tagList[i]}',
                            style: TextStyle(
                              color: Color(0xFFD29489),
                            ),
                          ),
                        ),
                      )
                    }
                  }
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'ABOUT :',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                WELCOME_TEXT,
                style: TextStyle(
                    color: Color(0xFF475464),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                formatAboutText()[0],
                style: TextStyle(color: Color(0xFF475464), fontSize: 15),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.only(top: 18, bottom: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xFF11D0A2),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10.0,
                          color: Color(0x566C809A),
                          offset: Offset(0, 5)),
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/checkout',
                        arguments: {
                          'id': eventDetails.id,
                          'checkout': {
                            'purchase': {
                              'id': eventDetails.id,
                              'name': eventDetails.name,
                              'price': eventDetails.price,
                              'location': eventDetails.location,
                              'dateTime': eventDetails.dateTime
                            },
                          },
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      child: Center(
                          child: Text(
                        '£${eventDetails.price} - I’M IN!',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 123, vertical: 11),
                child:
                    Divider(height: 11, thickness: 5, color: Color(0xFFE5E4EB)),
              ),
              Text(formatAboutText()[1]),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 26),
                child: Divider(
                  height: 11,
                  thickness: 1,
                  color: Color(0xFFE5E4EB),
                ),
              ),
              Text(
                'VENUE INFORMATION:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Text(eventDetails.venueInformation),
              SizedBox(
                height: 34,
              ),
              Divider(
                height: 11,
                thickness: 1,
                color: Color(0xFFE5E4EB),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'EVENT CREATED BY :',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff475464)),
              ),
              SizedBox(
                height: 17,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle_outlined),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(eventDetails.eventCreator),
                  )
                ],
              ),
              SizedBox(
                height: 17,
              ),
              Divider(
                height: 11,
                thickness: 1,
                color: Color(0xFFE5E4EB),
              ),
              SizedBox(
                height: 23,
              ),
              Text(
                'LOCATION :',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff475464)),
              ),
              SizedBox(
                height: 17,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 11),
                  Container(
                    width: 148,
                    child: Text(
                      eventDetails.location,
                      style: TextStyle(color: Color(0xFF475464)),
                    ),
                  ),
                  Spacer(),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF6658D3),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          String googleUrl =
                              '$GOOGLE_URL${eventDetails.location}';
                          canLaunch(googleUrl)
                              .then((value) => {launch(googleUrl)});
                          //   throw 'Could not open the map.';
                        },
                        child: Container(
                          height: 38,
                          width: 119,
                          child: Center(
                            child: Text(
                              'Take me there',
                              style: TextStyle(
                                color: Color(0xFF6658D3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Divider(
                height: 11,
                thickness: 1,
                color: Color(0xFFE5E4EB),
              ),
              SizedBox(
                height: 23,
              ),
              Text(
                'CONTACT :',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff475464)),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send us an email at',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Uri _emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'contact@techalchemy.co',
                          queryParameters: {
                            'subject': "This%20is%20my%20subject",
                            'body':
                                "Hey%20there%20i%20am%20from%20tech%20alclemy"
                          },
                        );
                        launch(_emailLaunchUri.toString());
                      },
                      child: Text(
                        ' contact@techalchemy.co',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6658D3)),
                      ),
                    ),
                    Text(
                      ' or call us at +1 991-681-0200',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 11,
                thickness: 1,
                color: Color(0xFFE5E4EB),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'TEAM INFORMATION :',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff475464)),
              ),
              SizedBox(height: 12),
              Text(
                eventDetails.teamInformation,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 10.29),
              ),
              SizedBox(
                height: 26,
              ),
              Divider(
                height: 11,
                thickness: 1,
                color: Color(0xFFE5E4EB),
              ),
              SizedBox(height: 25),
              Text(
                'SIMILAR EVENTS :',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff475464)),
              ),
              SizedBox(height: 17),
              BlocBuilder<AllEventBloc, AllEventsState>(
                  builder: (context, state) {
                if (state is SimilarEventsStateInitial ||
                    state is SimilarEventsStateLoadInProgress) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SimilarEventsStateLoadSuccess) {
                  return Container(
                    height: 390.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        AllEvents currentContent = state.similarEvents[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: BigMatchCard(
                            name: currentContent.name,
                            dateTime: currentContent.dateTime,
                            location: currentContent.location,
                            isPartnered: currentContent.isPartnered,
                            sport: currentContent.sport,
                            mainImage: currentContent.mainImage,
                            maxTicket: currentContent.maxTickets,
                            ticketSold: currentContent.ticketsSold,
                            totalPrice: currentContent.totalPrize,
                            price: currentContent.price,
                            id: currentContent.id,
                          ),
                        );
                      },
                    ),
                  );
                }

                return SizedBox();
              }),
              SizedBox(height: 170),
            ],
          ),
        ),
      ]),
    );
  }
}

class ParallaxImage extends StatelessWidget {
  ParallaxImage({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _buildParallaxBackground(context);
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        imgBoxContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
          height: 386.0,
        ),
      ],
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    @required this.scrollable,
    @required this.imgBoxContext,
    @required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext imgBoxContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final imageBox = imgBoxContext.findRenderObject() as RenderBox;
    final imageBoxOffset = imageBox.localToGlobal(
        imageBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (imageBoxOffset.dy / viewportDimension).clamp(-double.infinity, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext?.findRenderObject() as RenderBox)
            .size;
    final imgBoxSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & imgBoxSize);
    // Paint the background.
    context.paintChild(0,
        transform:
            Transform.translate(offset: Offset(0.0, childRect.top)).transform);
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        imgBoxContext != oldDelegate.imgBoxContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
