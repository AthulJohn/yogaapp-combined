import 'dart:convert';

import 'package:http/http.dart';

import '../constants/values.dart';
import '../models/person_model.dart';

///Used to register a new user.
///Returns the user's ID if successful, -1 otherwise.
Future<int> registerPerson(Person p) async {
  Uri? uri = Uri.tryParse("$url/register");
  try {
    if (uri != null) {
      Response response = await post(uri,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: jsonEncode(p.toJson()));
      print(response.body);
      if (response.statusCode == 200) {
        Map m = jsonDecode(response.body);
        return m['id'];
      } else {
        return -1;
      }
    } else {
      return -1;
    }
  } catch (e) {
    return -1;
  }
}
