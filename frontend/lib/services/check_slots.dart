import 'dart:convert';

import 'package:http/http.dart';
import '../constants/values.dart';

///Used to check the number of slots available in each slot.
///Returns a list of 4 integers, each representing the number of slots available in that slot.
///The list is ordered as follows: [slot1, slot2, slot3, slot4]
///If the request fails, returns a list of 4 zeroes.
Future<List<int>> checkSlots() async {
  Uri? uri = Uri.tryParse("$url/getbookingstats");
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
        Map<String, int> m = Map<String, int>.from(jsonDecode(response.body));
        return m.values.toList();
      }
      return [0, 0, 0, 0];
    } else {
      return [0, 0, 0, 0];
    }
  } catch (e) {
    return [0, 0, 0, 0];
  }
}
