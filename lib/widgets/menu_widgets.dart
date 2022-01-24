import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

menuCards(context, snapshot, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            backgroundColor: myWhite,
            radius: dynamicWidth(context, 0.08),
            child: CircleAvatar(
              backgroundColor: myWhite,
              radius: dynamicWidth(context, 0.075),
              backgroundImage: NetworkImage(snapshot[index]["photo"] ??
                  "https://hempbroker420.com/wp-content/uploads/2018/06/noimage.jpg"),
            ),
          ),
          widthBox(context, 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(context, snapshot[index]["name"], 0.03, myWhite, bold: true),
              text(
                context,
                "Rs ." + snapshot[index]["sale_price"],
                0.04,
                myWhite,
              ),
            ],
          ),
        ],
      ),
      cartIcon(context, snapshot[index])
    ],
  );
}

cartIcon(context, snapshot) {
  var quantity = 1;
  return StatefulBuilder(builder: (context, changeState) {
    return GestureDetector(
        onTap: () {
          if (!cartItems.contains(snapshot)) {
            snapshot["qty"] = quantity;
            snapshot['setState'] = () {
              changeState(() {});
            };
            cartItems.add(snapshot);

            changeState(() {});
          } else {
            cartItems.remove(snapshot);

            changeState(() {});
          }
        },
        child: cartItems.contains(snapshot)
            ? LineIcon(
                LineIcons.shoppingBasket,
                color: myOrange,
              )
            : LineIcon(
                LineIcons.shoppingBasket,
                color: myWhite,
              ));
  });
}

class CustomSearchDelegate extends SearchDelegate {
  dynamic menu;

  CustomSearchDelegate(this.menu);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        textSelectionTheme: const TextSelectionThemeData(cursorColor: myWhite),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: myBlack),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: myBlack),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: myBlack),
          ),
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: myWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(color: myBlack),
        scaffoldBackgroundColor: myBlack);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ) // IconButton
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    ); // IconButton
  }

  @override
  Widget buildResults(BuildContext context) {
    dynamic matchQuery = [];
    for (var item in menu) {
      if (item["name"].toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return Padding(
        padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
        child: ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, 0.01)),
                child: menuCards(context, matchQuery, index),
              );
            }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    dynamic matchQuery = [];
    for (var item in menu) {
      if (item["name"].toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Padding(
        padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
        child: ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, 0.01)),
                child: menuCards(context, matchQuery, index),
              );
            }));
  }
}
