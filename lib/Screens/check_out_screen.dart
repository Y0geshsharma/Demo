import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:yogesh_sharma/Components/DashedRect.dart';
import 'package:yogesh_sharma/Components/LoaderPage.dart';
import 'package:yogesh_sharma/Components/purchase_loader.dart';
import 'package:yogesh_sharma/Models/Payment/check_out.dart';
import 'package:yogesh_sharma/bloc/Checkout/checkout_bloc.dart';
import 'package:yogesh_sharma/bloc/Checkout/checkout_state.dart';
import 'package:yogesh_sharma/bloc/Purchase/purchase_bloc.dart';
import 'package:yogesh_sharma/bloc/Purchase/purchase_state.dart';
import 'package:yogesh_sharma/global_function.dart';
// class CartData {
//   bool ispurchased;
// }

class CheckoutOutScreen extends StatefulWidget {
  const CheckoutOutScreen({Key key}) : super(key: key);

  @override
  _CheckoutOutScreenState createState() => _CheckoutOutScreenState();
}

class _CheckoutOutScreenState extends State<CheckoutOutScreen> {
  bool isPurchased = false;
  void navigateBack() {
    if (isPurchased) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutStateInitial ||
            state is CheckoutStateLoadInProgress) {
          return LoaderPage();
        }
        if (state is CheckoutStateLoadSuccess) {
          return checkOutCard(context, state.checkout);
        }
        return SizedBox();
      },
    );
  }

  Widget checkOutCard(BuildContext contex, CheckOut checkOut) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(checkOut.mainImage),
                    ),
                  ),
                )),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Material(
                    clipBehavior: Clip.none,
                    color: Colors.black26,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              if (isPurchased) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', (route) => false);
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: Icon(Icons.ios_share),
                            onPressed: () {
                              Share.share("Hey there! This is Tech Alchemy!");
                            },
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            BottomPanel(isPurchased: isPurchased, checkOut: checkOut),
            Positioned(
                bottom: 20.0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!isPurchased)
                          isPurchased = true;
                        else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (route) => false);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: isPurchased
                              ? Theme.of(context).accentColor
                              : Color(0xFF11D0A2),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      duration: Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          isPurchased ? "CLOSE" : "PAY NOW",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class BottomPanel extends StatelessWidget {
  BottomPanel({
    this.isPurchased,
    this.checkOut,
  });
  final bool isPurchased;
  final CheckOut checkOut;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return DraggableScrollableSheet(
        minChildSize: 0.75,
        initialChildSize: 0.75,
        builder: (ctx, controller) => SingleChildScrollView(
              controller: controller,
              child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10.0,
                            offset: Offset(0, -5.0),
                            color: Colors.black26)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: screenWidth,
                        color: Colors.white,
                        height: screenHeight * 0.75,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 2.0),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        isPurchased
                                            ? SizedBox()
                                            : GestureDetector(
                                                onTap: () {
                                                  if (isPurchased) {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            '/home',
                                                            (route) => false);
                                                  } else {
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.0),
                                                    child: Icon(
                                                      Icons.arrow_back,
                                                    )),
                                              ),
                                        Text(
                                          "Purchase${isPurchased ? 'd' : ''}",
                                          style: TextStyle(fontSize: 18.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (isPurchased) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/home', (route) => false);
                                      } else {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Icon(Icons.close),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: isPurchased
                                  ? greetingsSheet(
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                    )
                                  : PaymentSheet(
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      checkOut: checkOut),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ));
  }
}

class PaymentSheet extends StatelessWidget {
  const PaymentSheet({
    Key key,
    @required this.screenWidth,
    @required this.screenHeight,
    this.checkOut,
  });

  final double screenWidth;
  final double screenHeight;
  final CheckOut checkOut;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.none,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 15.0,
                  color: Color(0x48473087),
                  offset: Offset(0, 10))
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    gradient: LinearGradient(stops: [
                      0.5,
                      1
                    ], colors: [
                      Theme.of(context).accentColor,
                      Theme.of(context).accentColor.withOpacity(0.5)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150.0,
                          child: Text(
                            checkOut.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 17.0),
                          ),
                        ),
                        if (checkOut.isPrivate) ...{
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                                color: Color(0xFFFF3FD5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0x663B2871),
                                      blurRadius: 5.0,
                                      offset: Offset(0, 5.0))
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Text(
                              "PRIVATE",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12.0),
                            ),
                          )
                        }
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        children: [
                          TimingRow(
                            icon: Icons.schedule,
                            text: convertMicrosecondsToDateTime(
                                checkOut.dateTime),
                          ),
                          TimingRow(
                            icon: Icons.place_outlined,
                            text: checkOut.location,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Price",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                              Text("£${checkOut.price}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 23.0))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3.0),
                            child: Text(
                              "(including 10% booking fee)",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 80.0,
                left: 0,
                right: 0,
                child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 1.0,
                        width: screenWidth,
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: DashedRect(
                          color: Color(0xffD3C8EF),
                          strokeWidth: 1.0,
                          gap: 8.0,
                        ),
                      ),
                      Positioned(left: -10.0, child: CircleDot()),
                      Positioned(right: -10.0, child: CircleDot()),
                    ]),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Choose your payment method",
                  style: TextStyle(fontSize: 13.0, color: Color(0xFF353B48)),
                ),
              ),
              PaymentChooser()
            ],
          ),
        )
      ],
    );
  }
}

class CircleDot extends StatelessWidget {
  const CircleDot({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(9.0),
      ),
    );
  }
}

class TimingRow extends StatelessWidget {
  const TimingRow({Key key, this.icon, this.text}) : super(key: key);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(
            right: 10.0,
          ),
          child: Icon(
            this.icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        )
      ]),
    );
  }
}

final List<Map> paymentMethods = [
  {"type": "Visa", 'asset_img': 'assets/img_visa.png'},
  {"type": "Master", 'asset_img': 'assets/img_master.png'},
  {"type": "Paypal", 'asset_img': 'assets/img_paypal.png'},
];

class PaymentChooser extends StatefulWidget {
  const PaymentChooser({Key key}) : super(key: key);

  @override
  _PaymentChooserState createState() => _PaymentChooserState();
}

class _PaymentChooserState extends State<PaymentChooser> {
  int choice = 0;

  void _onPayCardPress(card) {
    setState(() {
      choice = paymentMethods.indexOf(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      child: ListView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        children: paymentMethods
            .map((p) => PaymentCard(
                isSelected: choice == paymentMethods.indexOf(p),
                onCardPress: () => _onPayCardPress(p),
                data: p))
            .toList(),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({Key key, this.isSelected, this.onCardPress, this.data})
      : super(key: key);
  final bool isSelected;
  final Function onCardPress;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: isSelected ? 1 : 0.3,
      child: AnimatedContainer(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(right: 10.0),
        width: 102.0,
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: isSelected ? Colors.teal : Colors.transparent,
                width: 0.7),
            boxShadow: [
              BoxShadow(
                  blurRadius: 30.0,
                  color: Colors.black12,
                  offset: Offset(0, 8.0))
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onCardPress,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(data['asset_img']),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Icon(
                    Icons.check_circle_outline_outlined,
                    size: 20.0,
                    color: isSelected ? Colors.teal : Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget greetingsSheet({
  double screenWidth,
  double screenHeight,
}) {
  return BlocBuilder<PurchaseBloc, PurchaseState>(builder: (context, state) {
    if (state is PurchaseStateInitial || state is PurchaseStateLoadInProgress) {
      return PurchaseLoader();
    }
    if (state is PurchaseStateLoadSuccess) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30.0).copyWith(top: 40.0),
              child: DecoratedBox(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 20.0,
                      color: Colors.black12,
                      offset: Offset(0, 5))
                ], color: Color(0xFF11D0A2), shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.check,
                    size: 35.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              "Thank You!",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
            ),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                width: 200.0,
                child: Text("Your Payment was made successfully!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF475464),
                        fontWeight: FontWeight.w300))),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text("Your booking ID",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF475464),
                      fontWeight: FontWeight.w300)),
            ),
            Text(
              '#${state.purchase.id}',
              style: TextStyle(
                  color: Color(0xFF02D9E7),
                  fontWeight: FontWeight.w600,
                  fontSize: 30.0),
            ),
            Divider(),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                width: 280.0,
                child: Text(
                    "You will need this booking ID to enter inside the event. You can view this code inside your profile / booked events",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF475464),
                        fontWeight: FontWeight.w300))),
          ],
        ),
      );
    }
  });
}
