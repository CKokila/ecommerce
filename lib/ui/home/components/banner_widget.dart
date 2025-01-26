import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/const/string.dart';
import 'package:flutter/material.dart';

import '../../../const/color.dart';
import '../../widget/cache_image.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int currentIndex = 0;
  List<String> imageList = [
    BannerImage.jewellery,
    BannerImage.women,
    BannerImage.men,
    BannerImage.electronics,
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Special Offer",style: textTheme.titleMedium?.merge(TextStyle(fontWeight: FontWeight.bold)),),
        SizedBox(height: 10),
        CarouselSlider(
          options: CarouselOptions(
              height: 180,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              onPageChanged: (index, v) {
                setState(() {
                  currentIndex = index;
                });
              }),
          items: imageList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: cacheImage(
                    i,
                    width: width - 10,
                    height: 180,
                    borderRadius: 20,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
              imageList.length,
              (index) => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: buildDot(index)),
                  )),
        )
      ],
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      margin: const EdgeInsets.only(right: 12),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color:
              currentIndex == index ? kPrimaryLight : const Color(0xffd8d8d8),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
