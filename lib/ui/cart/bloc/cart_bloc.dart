import 'package:ecommerce/data/prefs/current_user.dart';
import 'package:ecommerce/data/repo/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/data/repo/cart_repo.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/product_model.dart';
import '../../../utils/converter.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo = CartRepo();
  ProductRepo productRepo = ProductRepo();
  final CurrentUser _user = CurrentUser();

  CartBloc() : super(CartInitial()) {
    on<FetchCart>(_fetchCart);
    on<UpdateCart>(_updateCart);
    on<DeleteCart>(_deleteCart);
    on<ClearCart>(_clearCart);
  }

  Future<void> _fetchCart(FetchCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      // Fetch cart data for the user
      CartModel cart = await cartRepo.getCartForUser();

      // Fetch product details for each product in the cart
      List<ProductCart> enrichedProducts = [];
      for (var product in (cart.products ?? [])) {
        try {
          ProductModel productDetails =
              await productRepo.getProduct(product.productId.toString());
          enrichedProducts.add(ProductCart(
              productId: product.productId,
              quantity: product.quantity,
              category: productDetails.category,
              image: productDetails.image,
              title: productDetails.title,
              totalPrice: product.quantity * productDetails.price));
        } catch (e) {
          // If fetching product details fails, add the product with basic details
          enrichedProducts.add(product);
        }
      }

      // Create an enriched cart model
      CartModel enrichedCart = CartModel(
        id: cart.id,
        userId: cart.userId,
        date: cart.date,
        products: enrichedProducts,
      );

      emit(CartLoaded(cart: enrichedCart));
    } catch (error) {
      emit(CartError(error: error.toString()));
    }
  }

  Future<void> _updateCart(UpdateCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      CartModel updatedCart =
          await cartRepo.updateCart(event.cartId.toString(), {
        "userId": _user.getCustomerId,
        "date": Converter.dateTimeFormat(DateTime.now(), "yyyy-MM-dd"),
        "products": event.products
            .map((p) => {
                  "productId": p.productId,
                  "quantity": p.quantity,
                })
            .toList()
      });
      emit(CartUpdated(cart: updatedCart));
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> _deleteCart(DeleteCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await cartRepo.deleteCart(event.cartId.toString());
      emit(CartDeleted());
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> _clearCart(ClearCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await cartRepo.deleteCart(event.cartId.toString());
      emit(CartCleared());
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }
}
