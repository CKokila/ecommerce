import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/ui/product_detail/bloc/product_bloc.dart';
import 'package:ecommerce/ui/product_detail/component/price_card.dart';
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
            if (state is CartUpdated) {
              productBloc.add(FetchProduct(id: widget.id));
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
                PriceCard(
                  product: product,
                  onRemove: () {
                    product.cartQty--;
                    productBloc.add(AddToCart(
                        productId: product.id.toString(),
                        quantity: product.cartQty));
                  },
                  onAdd: () {
                    product.cartQty++;
                    productBloc.add(AddToCart(
                        productId: product.id.toString(),
                        quantity: product.cartQty));
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
