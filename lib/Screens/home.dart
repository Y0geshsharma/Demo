import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: homeAppBar(context),
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

  SingleChildScrollView homeScreen(
      BuildContext context, List<AllEvents> eventList) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  child: Text(eventList[index].name),
                  onTap: () {
                    Navigator.of(context).pushNamed('/second', arguments: {
                      'id': eventList[index].id,
                      'catagory': eventList[index].sport
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  AppBar homeAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      title: Scaffold(
        body: Column(
          children: [
            Text('Welcome'),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(
                  Icons.settings_input_composite_outlined,
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        Badge(
          badgeContent: Text('3'),
          child: Icon(Icons.notifications_none_outlined),
        ),
      ],
    );
  }
}
