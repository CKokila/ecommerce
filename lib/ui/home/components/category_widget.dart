import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/routing/app_router.dart';
import 'package:ecommerce/utils/local_data.dart';
import 'package:flutter/material.dart';

import '../../../const/color.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: textTheme.titleMedium
                  ?.merge(TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  Category category = categoriesList[index];
                  return InkWell(
                    onTap: () {
                      context.router.pushNamed("/products/${category.name}");
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: kContainerColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Image.asset(
                                category.image,
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            category.name,
                            style:
                                textTheme.bodySmall?.apply(fontWeightDelta: 12),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
