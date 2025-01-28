import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/ui/product_listing/bloc/product_listing_bloc.dart';
import 'package:ecommerce/ui/product_listing/components/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../data/model/product_model.dart';
import '../../routing/app_router.dart';
import '../widget/common.dart';

@RoutePage(name: "ProductListingRoute")
class ProductListing extends StatefulWidget {
  final String category;

  const ProductListing({super.key, @PathParam('category') required this.category});

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  List<ProductModel> productList = [];
  ProductListingBloc productListingBloc = ProductListingBloc();
  bool isAscending = true;

  @override
  void initState() {
    productListingBloc.add(FetchProduct(category: widget.category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return BlocListener<ProductListingBloc, ProductListingState>(
      bloc: productListingBloc,
      listener: (context, state) {
        if (state is ProductListingLoaded) {
          productList = state.productList;
        }
      },
      child: BlocBuilder<ProductListingBloc, ProductListingState>(
        bloc: productListingBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.white, // Navigation bar
                statusBarColor: Colors.white, // Status bar
              ),
              automaticallyImplyLeading: true,
              title: Text(widget.category),
              actions: [
                IconButton(
                    onPressed: () {
                      isAscending = !isAscending;
                      productListingBloc.add(FetchProduct(
                          category: widget.category, sort: isAscending ? "asc" : "desc"));
                    },
                    icon: Icon(Icons.sort))
              ],
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      children: [
                        for (var i in productList) ...[
                          InkWell(
                            onTap: () {
                              context.router.push(ProductDetailRoute(id: i.id.toString()));
                            },
                            child: ProductItem(product: i),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
                if (state is! ProductListingLoading && productList.isEmpty) ...[
                  productEmpty(
                      context: context, message: "No products available in ${widget.category}!")
                ],
                if (state is ProductListingLoading) ...[circularProgress(true, context)],
              ],
            ),
          );
        },
      ),
    );
  }
}
