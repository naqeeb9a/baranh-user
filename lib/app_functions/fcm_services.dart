import 'dart:convert';

import 'package:baranh/utils/config.dart';
import 'package:http/http.dart' as http;

class FCMServices {
  static Future<http.Response> sendFCM(topic, id, title, description) {
    // print("object77");
    return http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "key=$serverKey",
      },
      body: jsonEncode({
        "to": "/topics/$topic",
        "notification": {
          "title": title,
          "body": description,
        },
        "data": {
          "id": id,
        }
      }),
    );
  }
}
