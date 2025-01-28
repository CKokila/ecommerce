import 'package:bloc/bloc.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/data/prefs/current_user.dart';
import 'package:ecommerce/data/repo/product_repo.dart';
import 'package:ecommerce/utils/converter.dart';
import 'package:meta/meta.dart';

import '../../../data/repo/cart_repo.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepo productRepo = ProductRepo();
  final CartRepo cartRepo = CartRepo();
  final CurrentUser _user = CurrentUser();

  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>(_fetchProductWithCartQty);
    on<AddToCart>(_addToCart);
    on<UpdateCartQty>(_updateCartQty);
  }

  Future<void> _fetchProductWithCartQty(
      FetchProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      var product = await productRepo.getProduct(event.id);
      var cartItems = await cartRepo.getAllCarts();
      for (var cart in cartItems) {
        for (var cartProduct in (cart.products ?? [])) {
          if (cartProduct.productId == product.id) {
            product.cartQty = cartProduct.quantity;
            break;
          }
        }
      }

      emit(ProductLoaded(product: product));
    } catch (error) {
      emit(DataError(error: error.toString()));
    }
  }

  Future<void> _addToCart(AddToCart event, Emitter<ProductState> emit) async {
    try {
      await cartRepo.createCart({
        "userId": Converter.getNum(_user.getCustomerId),
        "date": Converter.dateTimeFormat(DateTime.now(), "yyyy-MM-dd"),
        "products": [
          {"productId": Converter.getNum(event.productId), "quantity": event.quantity}
        ]
      });

      emit(CartUpdated());
    } catch (error) {
      emit(DataError(error: error.toString()));
    }
  }

  Future<void> _updateCartQty(
      UpdateCartQty event, Emitter<ProductState> emit) async {
    try {
      var existingCart = await cartRepo.getAllCarts();

      for (var cart in existingCart) {
        for (var cartProduct in (cart.products ?? [])) {
          if (cartProduct.productId == event.productId) {
            cartProduct.quantity = event.quantity;

            await cartRepo.updateCart(
              cart.id.toString(),
              {
                "userId": cart.userId,
                "date": cart.date,
                "products": cart.products
                    ?.map((p) => {
                          "productId": p.productId,
                          "quantity": p.quantity,
                        })
                    .toList()
              },
            );
            emit(CartUpdated());
            return;
          }
        }
      }

      emit(DataError(error: "Product not found in cart."));
    } catch (error) {
      emit(DataError(error: error.toString()));
    }
  }
}
