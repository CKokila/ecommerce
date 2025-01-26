import 'package:auto_route/annotations.dart';
import 'package:ecommerce/const/color.dart';
import 'package:ecommerce/const/string.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/ui/home/bloc/home_bloc.dart';
import 'package:ecommerce/ui/home/components/category_widget.dart';
import 'package:ecommerce/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/banner_widget.dart';
import 'components/product_item.dart';
import 'components/product_search.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  List<ProductModel> topProductList = [];

  @override
  void initState() {
    homeBloc.add(FetchTopProductDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kPrimaryLight,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
            bloc: homeBloc,
            listener: (context, state) {
              if (state is TopProductDataLoaded) {
                topProductList = state.products;
              }
            },
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: kPrimaryLight,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Location",
                                style: textTheme.bodySmall
                                    ?.apply(color: Colors.white)),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded,
                                    color: Colors.white),
                                SizedBox(width: 5),
                                Text("New york, USA",
                                    style: textTheme.bodyMedium
                                        ?.apply(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: borderRadiusAll_5
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.notifications_sharp,color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    elevation: 10.0,
                    automaticallyImplyLeading: false,
                    floating: true,
                    snap: false,
                  )
                ];
              },
              body: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kPrimaryLight,
                            borderRadius: headerRadius,
                            border: null),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ProductSearch(),
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {},
                          child: Scrollbar(
                            thumbVisibility: false,
                            radius: const Radius.circular(5),
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: mobilePadding,
                                  child: Column(
                                    children: [
                                      BannerWidget(),
                                      CategoryWidget(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Top Selling",
                                                style: textTheme.titleMedium
                                                    ?.merge(TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Text(
                                                "See all",
                                                style: textTheme.titleSmall
                                                    ?.merge(
                                                  TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            height: 270,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: topProductList.length,
                                              itemBuilder: (context, index) {
                                                ProductModel product =
                                                    topProductList[index];
                                                return HomeProductItem(
                                                    product: product);
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
