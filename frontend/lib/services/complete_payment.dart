import 'dart:convert';

import 'package:http/http.dart';
import '../constants/values.dart';

///Used to complete the payment of a user.
///Returns true if successful, false otherwise.
Future<bool> completePayment(int id, String method, double amount) async {
  Uri? uri = Uri.tryParse("$url/payfees");
  try {
    if (uri != null) {
      Response response = await put(uri,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"reg-id": id, "amount": amount, "method": method}));
      return response.statusCode == 200;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
