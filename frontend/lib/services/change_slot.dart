import 'dart:convert';

import 'package:http/http.dart';
import '../constants/values.dart';

///Used to change the slot of a user.
///Returns true if successful, false otherwise.
Future<bool> changeSlot(int id, int slot) async {
  Uri? uri = Uri.tryParse("$url/changeslot");
  try {
    if (uri != null) {
      Response response = await put(uri,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"reg-id": id, "slot": slot}));
      return response.statusCode == 200;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
