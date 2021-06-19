import 'package:http/http.dart' as http;
import 'package:yogesh_sharma/Constants/endpoints.dart';
import 'dart:convert' as convert;

import 'package:yogesh_sharma/Models/Events/event_details.dart';

class EventDetailsService {
  Future getDeatils(int id) async {
    Uri _url = Uri(host: '$EVENT_DETAILS/$id');

    Map<String, dynamic> collection;
    EventDetails details;
    var response = await http.get(
      _url,
      headers: {'Authorization': Token},
    );
    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      details = EventDetails.fromJson(collection);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return details;
  }
}
