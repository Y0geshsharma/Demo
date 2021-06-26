import 'package:http/http.dart' as http;
import 'package:yogesh_sharma/Constants/endpoints.dart';
import 'dart:convert' as convert;

import 'package:yogesh_sharma/Models/Events/event_details.dart';

class EventDetailsService {
  Future getDeatils(int id) async {
    Map<String, dynamic> collection;
    EventDetails details;
    var response = await http.Client().get(
      Uri.parse('$EVENT_DETAILS/$id'),
      headers: header,
    );
    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      details = EventDetails.fromJson(collection['eventDetail']);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return details;
  }
}
