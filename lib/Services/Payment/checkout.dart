import 'package:http/http.dart' as http;
import 'package:yogesh_sharma/Constants/endpoints.dart';
import 'dart:convert' as convert;

import 'package:yogesh_sharma/Models/Payment/check_out.dart';

class CheckoutService {
  Future getCheckoutDetails(int id) async {
    Map<String, dynamic> collection;
    CheckOut checkOutDetails;
    var response = await http.Client().get(
      Uri.parse('$CHECKOUT/$id'),
      headers: header,
    );
    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      checkOutDetails = CheckOut.fromJson(collection);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return checkOutDetails;
  }
}
