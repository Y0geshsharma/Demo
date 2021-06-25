import 'package:flutter/material.dart';

final List<Map> bottomNavIcons = <Map>[
  {
    "icon": Icon(Icons.home_outlined),
    "splashColor": Color(0xFF7555CF).withOpacity(0.3),
  },
  {
    "icon": Icon(Icons.local_activity_outlined),
    "splashColor": Color(0xFF7555CF).withOpacity(0.3),
  },
  {
    "icon": Icon(Icons.gamepad_outlined),
    "splashColor": Color(0xFF7555CF).withOpacity(0.3),
  },
  {
    "icon": Icon(Icons.person_outline_sharp),
    "splashColor": Color(0xFF7555CF).withOpacity(0.3),
  },
  {
    "icon": Icon(Icons.settings),
    "splashColor": Color(0xFF7555CF).withOpacity(0.3),
  },
];

class BottomNav extends StatefulWidget {
  const BottomNav({Key key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 20.0,
                color: Colors.black12,
                offset: Offset(-5.0, 0))
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0))),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding:
              EdgeInsets.all(8.0).add(EdgeInsets.symmetric(horizontal: 10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bottomNavIcons
                .map<Widget>(
                  (e) => IconButton(
                      highlightColor: Colors.transparent,
                      color: bottomNavIcons.indexOf(e) == currentIndex
                          ? Theme.of(context).accentColor
                          : Colors.black,
                      icon: e['icon'],
                      splashColor:
                          Theme.of(context).accentColor.withOpacity(0.3),
                      onPressed: () {
                        setState(() {
                          currentIndex = bottomNavIcons.indexOf(e);
                        });
                        // Navigator.of(context).pushNamed(
                        //     bottomNavIcons.indexOf(e) == 0 ? '/home' : '/book');
                      }),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
