
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
    return BlocConsumer<AllEventBloc, AllEventsState>(
      listener: (context, state) {
        if (state is AllEventsStateLoadInProgress ||
            state is AllEventsStateInitial) {
          return Scaffold(
            appBar: null,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return SizedBox();
      },
      builder: (context, state) {
        if (state is AllEventsStateLoadSuccess) {
          return homeScreen(context, state.allEvents);
        }
        return SizedBox();
      },
    );
  }

  Scaffold homeScreen(BuildContext context, List<AllEvents> eventList) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Text(eventList[index].name),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
