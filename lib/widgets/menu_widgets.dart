import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';

menuCards(context, snapshot, index) {
  return Container(
    decoration: BoxDecoration(
      color: myBlack,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, 0.02),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                dynamicWidth(context, 0.02),
              ),
              topRight: Radius.circular(
                dynamicWidth(context, 0.02),
              ),
            ),
            child: Image.network(
              snapshot[index]["photo"] ??
                  "https://hempbroker420.com/wp-content/uploads/2018/06/noimage.jpg",
              height: dynamicWidth(context, 0.2),
              width: dynamicWidth(context, 0.5),
              fit: BoxFit.cover,
              errorBuilder: (context, url, error) {
                return const Icon(Icons.error);
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.02),
          ),
          child: text(
            context,
            snapshot[index]["name"],
            0.03,
            myWhite,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.02)),
          child: text(
            context,
            "Rs ." + snapshot[index]["sale_price"],
            0.04,
            myWhite,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.02)),
          child: iconsRow(
            context,
            snapshot[index],
          ),
        ),
        heightBox(context, 0.005),
      ],
    ),
  );
}

iconsRow(context, snapshot) {
  var quantity = 1;
  return StatefulBuilder(builder: (context, changeState) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
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
              child: Container(
                height: dynamicWidth(context, 0.08),
                child: Center(
                  child: text(
                      context,
                      cartItems.contains(snapshot) ? "Added" : "Add to Cart",
                      0.04,
                      cartItems.contains(snapshot) ? myBlack : myWhite,
                      alignText: TextAlign.center),
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(dynamicWidth(context, 0.02)),
                  color: cartItems.contains(snapshot) ? myGrey : myOrange,
                ),
              )),
        ),
      ],
    );
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
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio:
                dynamicWidth(context, 0.5) / dynamicWidth(context, 0.5)),
        itemCount: matchQuery.length,
        itemBuilder: (BuildContext context, int index) {
          return menuCards(context, matchQuery, index);
        },
      ),
    );
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
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio:
                dynamicWidth(context, 0.5) / dynamicWidth(context, 0.5)),
        itemCount: matchQuery.length,
        itemBuilder: (BuildContext context, int index) {
          return menuCards(context, matchQuery, index);
        },
      ),
    ); // ListTile
  }
}
