import 'dart:convert';

import 'package:http/http.dart';
import '../constants/values.dart';

import '../models/person_model.dart';

///Used to identify the user and temporarily authorize them.
///Returns a [Person] object if successful, null otherwise.
///The [Person] object contains the user's name, phone number, and other details.
Future<Person?> authorize(String id, String phone) async {
  String authurl = "$url/authorize?reg-id=$id&phone=$phone";
  Uri? uri = Uri.tryParse(authurl);
  try {
    if (uri != null) {
      Response response = await get(
        uri,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> m = jsonDecode(response.body);
        return Person.fromJson(m);
      }
      return null;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
