import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../data/prefs/current_user.dart';
import '../../../data/repo/product_repo.dart';
import '../../../utils/log.dart';
import '../../widget/cache_image.dart';
import '../../widget/common.dart';
import '../../widget/textfield.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  TextEditingController searchCtr = TextEditingController();
  SuggestionsController<ProductModel> suggestionsController =
      SuggestionsController<ProductModel>();
  FocusNode searchFocus = FocusNode();
  ValueNotifier<List<ProductModel>> listener =
      ValueNotifier<List<ProductModel>>([]);
  ScrollController autocompleteScrCtr = ScrollController();
  List<ProductModel> searchProductList = [];
  bool isLoading = false;
  CurrentUser _user = CurrentUser();

  Future<List<ProductModel>> suggestionsCallback(String pattern) async =>
      Future<List<ProductModel>>.delayed(
        const Duration(milliseconds: 300),
        () => searchProductList.where((product) {
          final nameLower =
              (product.title ?? '').toLowerCase().split(' ').join('');
          final patternLower = pattern.toLowerCase().split(' ').join('');
          return nameLower.contains(patternLower);
        }).toList(),
      );

  void _productSearch(String keyword) {
    setState(() {
      isLoading = true;
    });
    ProductRepo().searchProduct(keyword).then((value) {
      setState(() {
        isLoading = false;
        searchProductList = value;
        listener.value = searchProductList;
        listener.notifyListeners();
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  _searchProduct(String keyword) {
    setState(() {
      Log.d("Entered keyword $keyword length");
      if (keyword.trim().isNotEmpty && keyword.trim().length > 1) {
        _productSearch(keyword);
      }
      if (keyword.trim().isEmpty) {
        Log.d("Empty value entered");
        searchProductList = [];
      }
      Log.d("Product list ${searchProductList.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return ValueListenableBuilder<List<ProductModel>>(
          valueListenable: listener,
          builder: (ctx, value, child) {
            return TypeAheadField<ProductModel>(
              scrollController: autocompleteScrCtr,
              controller: searchCtr,
              focusNode: searchFocus,
              hideOnLoading: true,
              retainOnLoading: true,
              suggestionsController: suggestionsController,
              constraints:
                  BoxConstraints(maxWidth: constraints.biggest.width - 10),
              suggestionsCallback: suggestionsCallback,
              decorationBuilder: (context, child) {
                return Material(
                    type: MaterialType.card,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: child);
              },
              itemBuilder: (context, product) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            cacheImage(product.image,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                borderRadius: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                product.title ?? '',
                                style: textTheme.titleSmall?.apply(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      textWithCurrency(
                          text: (product.price?.toStringAsFixed(2) ?? '0'),
                          style: textTheme.titleSmall!
                              .apply(color: Colors.black, fontWeightDelta: 12))
                    ],
                  ),
                );
              },
              itemSeparatorBuilder: (c, i) =>
                  Divider(color: theme.dividerColor.withOpacity(0.2)),
              emptyBuilder: (context) {
                return ((!isLoading) &&
                        searchCtr.text.length > 2 &&
                        searchCtr.text.isNotEmpty)
                    ? SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 20),
                          child: Row(
                            children: [
                              const Text("No results found for "),
                              Text(
                                "'${searchCtr.text}'",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox();
              },
              builder:
                  (BuildContext context, searchCtr, FocusNode fieldFocusNode) {
                return SearchField(
                  hintText: "Type product name to search",
                  height: 45,
                  borderRadius: 12,
                  onFieldSubmitted: (v) {
                    searchFocus.requestFocus();
                    // context.router.pushNamed('search-result/$v');
                  },
                  onChanged: _searchProduct,
                  filled: false,
                  textController: searchCtr,
                  focusNode: fieldFocusNode,
                );
              },
              onSelected: (ProductModel product) {
                // context.router.pushNamed('product/${product.productId}');
              },
            );
          },
        );
      },
    );
  }
}
