import 'package:auto_route/annotations.dart';
import 'package:ecommerce/const/color.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/ui/cart/bloc/cart_bloc.dart';
import 'package:ecommerce/ui/cart/component/price_breakup.dart';
import 'package:ecommerce/ui/widget/cache_image.dart';
import 'package:ecommerce/ui/widget/common.dart';
import 'package:ecommerce/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/dimens.dart';

@RoutePage(name: "CartRoute")
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBloc cartBloc = CartBloc();
  CartModel cart = CartModel();

  @override
  void initState() {
    cartBloc.add(FetchCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        return BlocListener<CartBloc, CartState>(
          bloc: cartBloc,
          listener: (context, state) {
            if (state is CartLoaded) {
              cart = state.cart;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("Cart"),
              actions: [
                InkWell(
                  onTap: () {
                    cartBloc.add(ClearCart(cartId: cart.id!));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Text(
                      "Clear cart",
                      style: TextStyle(color: kPrimaryLight),
                    ),
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: (cart.products ?? []).length,
                  itemBuilder: (context, index) {
                    final product = cart.products![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: kContainerColor,
                                      borderRadius: borderRadiusAll_10),
                                  padding: EdgeInsets.all(8),
                                  child: cacheImage(product.image!),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(product.title ?? '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        (product.category ?? 'Unknown')
                                            .capitalize(),
                                        style: TextStyle(color: kGrey),
                                      ),
                                      textWithCurrency(
                                        text: (product.totalPrice),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  cartBloc.add(UpdateCart(cartId: cart.id!, products: cart.products!));
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Color(0xffD6D6D6),
                                      borderRadius: borderRadiusAll_5),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: Text(product.quantity.toString()),
                              ),
                              InkWell(
                                onTap: () {
                                  cartBloc.add(UpdateCart(cartId: cart.id!, products: cart.products!));
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: kPrimaryLight,
                                      borderRadius: borderRadiusAll_5),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: PriceBreakup(cart: cart),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
