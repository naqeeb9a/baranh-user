import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic itemList = [
      {
        "img": "https://baranh.pk/pizzaro/images/front/300by300(2).jpg",
        "name": "TAWA CHICKEN"
      },
      {
        "img": "https://baranh.pk/pizzaro/images/front/300by300(4).jpg",
        "name": "TAWA QEEMA"
      },
      {
        "img": "https://baranh.pk/pizzaro/images/front/parotay.png",
        "name": "PATHORAY"
      },
    ];
    return Scaffold(
      backgroundColor: myBlack,
      body: SingleChildScrollView(
          child: Column(
        children: [
          heightBox(context, 0.05),
          slider(context),
          heightBox(context, 0.05),
          text(context, "OUR SPECIALTY", 0.05, myWhite, bold: true),
          heightBox(context, 0.02),
          listSpeciality(context, itemList),
          heightBox(context, 0.02),
          stackCard(
              context,
              "https://baranh.pk/assets/img/op-cover-04-small.jpg",
              "ORDER FOOD",
              "Order Food Online From The Best Restaurants And Shops On Baranh.",
              "Order Now"),
          stackCard(
              context,
              "https://baranh.pk/assets/img/op-cover-02-small.jpg",
              "TABLE RESERVATION",
              "Find Your Table For Any Occasion.",
              "Reserve Table", function: () {
            pageDecider = "New Reservations";
            globalRefresh();
          }),
          stackCard(
              context,
              "https://baranh.pk/assets/img/op-cover-03-small.jpg",
              "DISCOVER A UNIQUE EXPERIENCE",
              "We Bring Professional Chefs To Your Home To Prepare Delicious, Customized Meals At A Fraction Of The Cost.",
              "Menu"),
          stackCard(
              context,
              "https://baranh.pk/assets/img/op-cover-01-small-fix.jpg",
              "ABOUT US",
              "Exotic Food Of Old Lahore To Your City. A Myraid Variety Of Handpicked Cuisine To Capsulate What The True Lahore Food Represents.",
              "Menu",
              buttonVisible: false),
        ],
      )),
    );
  }
}

slider(context) {
  return CarouselSlider(
    options: CarouselOptions(
      height: dynamicWidth(context, 0.33),
      // viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    ),
    items: [
      "https://baranh.pk/assets/img/delicious-food-banner-d.jpg",
      "https://baranh.pk/assets/img/now-open-gulberg-web-d.jpg",
      "https://baranh.pk/assets/img/baranh_banner_hp_desktop_001.jpg",
    ].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(dynamicWidth(context, 0.04)),
            child: Image.network(
              i,
              fit: BoxFit.cover,
            ),
          );
        },
      );
    }).toList(),
  );
}

listSpeciality(context, itemList) {
  return SizedBox(
    height: dynamicWidth(context, 0.7),
    width: dynamicWidth(context, 1),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.03)),
          child: Column(
            children: [
              Image.network(
                itemList[index]["img"],
                width: dynamicWidth(context, 0.5),
                height: dynamicWidth(context, 0.6),
              ),
              text(context, itemList[index]["name"], 0.04, myWhite)
            ],
          ),
        );
      },
    ),
  );
}

Widget stackCard(context, img, text1, text2, buttonText,
    {buttonVisible = true, function = ""}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        height: dynamicHeight(context, 0.8),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(img),
          ),
        ),
      ),
      SizedBox(
        width: dynamicWidth(context, 0.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(context, text1, 0.1, myWhite,
                bold: true, alignText: TextAlign.center),
            heightBox(context, 0.02),
            text(context, text2, 0.04, myWhite, alignText: TextAlign.center),
            heightBox(context, 0.015),
            Visibility(
              visible: buttonVisible,
              child: coloredButton(context, buttonText, myOrange,
                  width: dynamicWidth(context, 0.4), function: function),
            ),
          ],
        ),
      )
    ],
  );
}
