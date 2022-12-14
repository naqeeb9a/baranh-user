import 'dart:convert';

import 'package:baranh/utils/config.dart';
import 'package:http/http.dart' as http;

getOrderSummary(id) async {
  try {
    var response =
        await http.get(Uri.parse(callBackUrl + "/api/order-summary/$id"));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

reserveTable(name, phone, email, seats, date, dropDownTime, outletId) async {
  try {
    var bodyRequest = {
      "name": "$name",
      "phone": "$phone",
      "email": "$email",
      "seats": "$seats",
      "date": "$date",
      "timedropdown": "$dropDownTime",
      "outlet_id": outletId,
      "reservation_type": "customer"
    };

    var response = await http.post(Uri.parse(callBackUrl + "/api/reserve"),
        body: json.encode(bodyRequest),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return jsonData["data"]["id"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

getTimeSlots(date, outletId) async {
  try {
    var response = await http.post(Uri.parse(callBackUrl + "/api/get-timeslot"),
        body: json.encode(
            {"outlet_id": "$outletId", "filter_date": date, "type": "online"}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

getMenu(id) async {
  try {
    var response = await http.get(Uri.parse(callBackUrl + "/api/menu/all-$id"));
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

punchOrder(total, cost, outletId, name, phone, email, address) async {
  var filteredItems = [];
  filterFunction() {
    for (var item in cartItems) {
      filteredItems.add({
        "productid": item["id"],
        "productname": item["name"],
        "productcode": item["code"],
        "productprice": item["sale_price"],
        "itemUnitCost": item["cost"] ?? "0",
        "productqty": item["qty"],
        "productimg": item["photo"]
      });
    }
    return filteredItems;
  }

  dynamic bodyJson = {
    "outlet_id": "$outletId",
    "total_items": "${cartItems.length}",
    "sub_total": "$total",
    "total_payable": "$total",
    "total_cost": "$cost",
    "cart": filterFunction(),
    "table_no": "",
    "saleid": "",
    "billing_name": "$name",
    "billing_email": "$email",
    "billing_phone": "$phone",
    "billing_address": "$address",
    "payment_method": "cod"
  };
  try {
    var response = await http.post(
      Uri.parse(callBackUrl + "/api/punch-order"),
      body: json.encode(bodyJson),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

checkAvailability(date, timeDropdown, seats, outletId) async {
  try {
    var response = await http.post(Uri.parse(callBackUrl + "/api/get-avail"),
        body: json.encode({
          "outlet_id": "$outletId",
          "filter_date": "$date",
          "timedropdown": "$timeDropdown",
          "seats": "$seats"
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return "internet";
    }
  } catch (e) {
    return "server";
  }
}

//---------Baranh User ------------
getOrderHistory(id) async {
  try {
    var response = await http.get(
      Uri.parse(callBackUrl + "/api/order-history/" + id),
    );
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"]["message"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

sendEmailForgotPassword(String email) async {
  var response = await http.post(
      Uri.parse(callBackUrl + "/api/forget-password-email"),
      body: {"email": email});
  var jsonData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return jsonData["data"]["message"];
  } else if (response.statusCode == 400) {
    return "No Email";
  } else {
    return false;
  }
}

getOutlets() async {
  try {
    var response = await http.get(
      Uri.parse(callBackUrl + "/api/outlets"),
    );
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

getQRSummary(apiCall) async {
  try {
    var response = await http
        .get(Uri.parse("Https://baranh.pk/api/barcode/" + apiCall.toString()));
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return jsonData["data"]["message"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

getVerified(saleId, code) async {
  try {
    var response = await http
        .post(Uri.parse(callBackUrl + "/api/customer-verify"), body: {
      "sale_id": saleId.toString(),
      "verification_code": code.toString()
    });
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
