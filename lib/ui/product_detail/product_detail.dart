import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/ui/product_detail/bloc/product_bloc.dart';
import 'package:ecommerce/ui/widget/cache_image.dart';
import 'package:ecommerce/ui/widget/common.dart';
import 'package:ecommerce/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/color.dart';
import '../../utils/dimens.dart';

@RoutePage(name: "ProductDetailRoute")
class ProductDetail extends StatefulWidget {
  final String id;

  const ProductDetail({super.key, @PathParam('id') required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductBloc productBloc = ProductBloc();
  ProductModel product = ProductModel();

  @override
  void initState() {
    productBloc.add(FetchProduct(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: productBloc,
      builder: (context, state) {
        return BlocListener<ProductBloc, ProductState>(
          bloc: productBloc,
          listener: (context, state) {
            if (state is ProductLoaded) {
              product = state.product;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kContainerColor,
              title: Text(product.title ?? ''),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(Icons.favorite_border_rounded),
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: kContainerColor,
                        width: width,
                        height: height * 0.35,
                        padding: EdgeInsets.all(8),
                        child: cacheImage(product.image),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (product.category ?? "").capitalize(),
                                  style: TextStyle(color: kGrey),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star_rounded,
                                        color: Colors.orange, size: 18),
                                    Text(
                                      (product.rating?.rate ?? 0).toString(),
                                      style: textTheme.bodyMedium
                                          ?.apply(color: kGrey),
                                    ),
                                    Text(
                                      "( ${(product.rating?.count ?? 0).toString()} )",
                                      style: textTheme.bodyMedium
                                          ?.apply(color: kGrey),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              (product.title ?? ""),
                              style: textTheme.titleLarge
                                  ?.apply(fontWeightDelta: 12),
                            ),
                            SizedBox(height: 10),
                            Text(
                              (product.description ?? ""),
                              style: textTheme.titleMedium,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Align(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Price",
                              style: textTheme.titleMedium?.apply(
                                  color: Colors.grey, fontWeightDelta: 12),
                            ),
                            textWithCurrency(
                              text: product.price.toString(),
                              style: textTheme.titleMedium
                                  ?.apply(fontWeightDelta: 12),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8),
                            child: Row(
                              children: [
                                Icon(Icons.shopping_cart, color: Colors.white),
                                SizedBox(width: 10),
                                Text("Add to cart"),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
