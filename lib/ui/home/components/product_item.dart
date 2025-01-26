import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/ui/widget/cache_image.dart';
import 'package:ecommerce/ui/widget/common.dart';
import 'package:ecommerce/utils/extension.dart';
import 'package:flutter/material.dart';

import '../../../const/color.dart';
import '../../../utils/dimens.dart';

class HomeProductItem extends StatelessWidget {
  final ProductModel product;

  const HomeProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double kContainerWidth = 200;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: kContainerWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadiusAll_8,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ]),
        child: Column(
          children: [
            Container(
              width: kContainerWidth,
              height: 150,
              decoration: BoxDecoration(
              color: kContainerColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: cacheImage(product.image,
                    width: 80, height: 80, fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        product.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.apply(fontWeightDelta: 12),
                      )),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          Icon(Icons.star_rounded,
                              color: Colors.orange, size: 15),
                          Text(
                            (product.rating?.rate ?? 0).toString(),
                            style: textTheme.bodySmall,
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    (product.category ?? '').capitalize(),
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: 10),
                  textWithCurrency(
                      text: product.price.toString(),
                      style: textTheme.bodyMedium?.apply(fontWeightDelta: 12))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
