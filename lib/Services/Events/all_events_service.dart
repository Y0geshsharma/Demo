import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:yogesh_sharma/Constants/endpoints.dart';
import 'dart:convert' as convert;

import 'package:yogesh_sharma/Models/Events/all_events.dart';

class AllEventService {
  Future<List<AllEvents>> getAllEvent() async {
    Map<String, dynamic> collection;
    List<AllEvents> events;
    var response = await http.Client().get(
      Uri.parse(ALL_EVENTS),
      headers: header,
    );
    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      final allEvents = collection['allEvents'];
      events =
          allEvents.map<AllEvents>((json) => AllEvents.fromJson(json)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    print(events.runtimeType);

    return events;
  }

  Future<List<AllEvents>> getSimilarEvent(String catagory) async {
    Map<String, dynamic> collection;
    List<AllEvents> events;
    DateFormat parser = DateFormat('M/dd/yyyy HH:mm:ss');
    var response = await http.Client().get(
      Uri.parse('$ALL_EVENTS/?filter[sport]=$catagory'),
      headers: header,
    );
    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      events = collection['allEvents']
          .map<AllEvents>((json) => AllEvents.fromJson(json))
          .toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    events.sort(
      (a, b) {
        return parser.parse(b.dateTime).compareTo(parser.parse(a.dateTime));
      },
    );
    return events;
  }
}
