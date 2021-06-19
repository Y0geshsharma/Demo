import 'package:http/http.dart' as http;
import 'package:yogesh_sharma/Constants/endpoints.dart';
import 'dart:convert' as convert;

import 'package:yogesh_sharma/Models/Payment/check_out.dart';
import 'package:yogesh_sharma/Models/Payment/purchase.dart';

class PurchaseService {
  Future getPurchase(CheckOut body) async {
    Map<String, dynamic> collection;
    Purchase purchase;
    var response = await http.Client()
        .post(Uri.parse('$PURCHASE'), headers: header, body: body);
    if (response.statusCode == 200) {
      collection = convert.jsonDecode(response.body);
      purchase = Purchase.fromJson(collection);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return purchase;
  }
}
