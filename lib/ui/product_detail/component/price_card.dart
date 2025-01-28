import 'package:ecommerce/data/model/product_model.dart';
import 'package:flutter/material.dart';

import '../../../const/color.dart';
import '../../../utils/dimens.dart';
import '../../widget/common.dart';

class PriceCard extends StatelessWidget {
  final ProductModel product;
  final void Function()? onAdd;
  final void Function()? onRemove;

  const PriceCard(
      {super.key, required this.product, this.onAdd, this.onRemove});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: width,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadiusAll_10,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ]),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Price",
                    style: textTheme.titleMedium
                        ?.apply(color: Colors.grey, fontWeightDelta: 12),
                  ),
                  textWithCurrency(
                    text: product.totalPrice,
                    style: textTheme.titleMedium?.apply(fontWeightDelta: 12),
                  )
                ],
              ),
            ),
            SizedBox(width: 20),
            if (product.isInCart) ...[
              InkWell(
                onTap: onRemove,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: kPrimaryLight, borderRadius: borderRadiusAll_5),
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(product.cartQty.toString()),
              ),
              InkWell(
                onTap: onAdd,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: kPrimaryLight, borderRadius: borderRadiusAll_5),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: onAdd,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.white),
                      SizedBox(width: 10),
                      Text("Add to cart"),
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
