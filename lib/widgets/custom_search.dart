import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/table_cards.dart';
import 'package:flutter/material.dart';

class CustomDineInSearchDelegate extends SearchDelegate {
  dynamic data,
      setState,
      assignTable,
      buttonText1,
      buttonText2,
      function1check,
      function2check;

  CustomDineInSearchDelegate(
    this.data,
    this.setState,
    this.assignTable,
    this.buttonText1,
    this.buttonText2,
  );

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
                // headline 6 affects the query text
                color: myWhite,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
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
    if (pageDecider == "Dine In Orders") {
      for (var item in data) {
        if (item["table_name"]
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          matchQuery.add(item);
        }
      }
    } else {
      for (var item in data) {
        if (item["customer_name"]
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item["customer_phone"]
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
          matchQuery.add(item);
        }
      }
    }
    return Padding(
        padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
        child: ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (BuildContext context, int index) {
            return tableCardsExtension(
              context,
              matchQuery,
              index,
              buttonText1,
              buttonText2,
              function: setState,
              assignTable: assignTable,
            );
          },
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    dynamic matchQuery = [];
    if (pageDecider == "Dine In Orders") {
      for (var item in data) {
        if (item["table_name"]
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          matchQuery.add(item);
        }
      }
    } else {
      for (var item in data) {
        if (item["customer_name"]
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item["customer_phone"]
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
          matchQuery.add(item);
        }
      }
    }
    return Padding(
      padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (BuildContext context, int index) {
          return tableCardsExtension(
            context,
            matchQuery,
            index,
            buttonText1,
            buttonText2,
            function: setState,
            assignTable: assignTable,
          );
        },
      ),
    ); // ListTile
  }
}
