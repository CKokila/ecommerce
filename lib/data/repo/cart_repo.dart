import 'package:ecommerce/data/api/api_server.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/data/prefs/current_user.dart';
import 'package:ecommerce/utils/converter.dart';

import '../../utils/log.dart';
import '../api/api_response.dart';

class CartRepo {
  final ApiServer _client = ApiServer();
  final CurrentUser _user = CurrentUser();

  // Get all carts
  Future<List<CartModel>> getAllCarts() async {
    List<CartModel> cartResponse;
    try {
      ApiResponse response =
          await _client.get("carts/user/${_user.getCustomerId}");
      var data = response.data;
      cartResponse =
          List<CartModel>.from(data.map((e) => CartModel.fromJson(e)));
      return cartResponse;
    } catch (e) {
      Log.d("getAllCarts Catch ${e.toString()}");
      return Future.error(e.toString());
    }
  }

  Future<CartModel> getCartForUser() async {
    try {
      int userId = Converter.getInt(_user.getCustomerId);
      ApiResponse response = await _client.get("carts");
      var data = response.data;
      List<CartModel> allCarts =
      List<CartModel>.from(data.map((e) => _mapCartFromJson(e)));

      // Filter carts by userId and return the first one (latest cart)
      CartModel? userCart =
      allCarts.firstWhere((cart) => cart.userId == userId, orElse: () => throw Exception("Cart not found"));
      return userCart;
    } catch (e) {
      Log.d("Error in getCartForUser: ${e.toString()}");
      return Future.error(e.toString());
    }
  }

  CartModel _mapCartFromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      date: json['date'] as String,
      products: List<ProductCart>.from(
        json['products'].map(
              (e) => ProductCart(
            productId: e['productId'] as int,
            quantity: e['quantity'] as int,
          ),
        ),
      ),
    );
  }

  // Get a single cart
  Future<CartModel> getCart(String id) async {
    CartModel cartResponse;
    try {
      ApiResponse response = await _client.get("carts/$id");
      var data = response.data;
      cartResponse = CartModel.fromJson(data);
      return cartResponse;
    } catch (e) {
      Log.d("getCart Catch ${e.toString()}");
      return Future.error(e.toString());
    }
  }

  // Create a new cart
  Future<CartModel> createCart(Map<String, dynamic> cartData) async {
    CartModel cartResponse;
    try {
      ApiResponse response = await _client.post("carts", data: cartData);
      var data = response.data;
      cartResponse = CartModel.fromJson(data);
      return cartResponse;
    } catch (e) {
      Log.d("createCart Catch ${e.toString()}");
      return Future.error(e.toString());
    }
  }

  // Update a cart (PUT)
  Future<CartModel> updateCart(String id, Map<String, dynamic> cartData) async {
    CartModel cartResponse;
    try {
      ApiResponse response = await _client.put("carts/$id", data: cartData);
      var data = response.data;
      cartResponse = CartModel.fromJson(data);
      return cartResponse;
    } catch (e) {
      Log.d("updateCart Catch ${e.toString()}");
      return Future.error(e.toString());
    }
  }

  // Update a cart partially (PATCH)
  Future<CartModel> patchCart(String id, Map<String, dynamic> cartData) async {
    CartModel cartResponse;
    try {
      ApiResponse response = await _client.patch("carts/$id", data: cartData);
      var data = response.data;
      cartResponse = CartModel.fromJson(data);
      return cartResponse;
    } catch (e) {
      Log.d("patchCart Catch ${e.toString()}");
      return Future.error(e.toString());
    }
  }

  // Delete a cart
  Future<void> deleteCart(String id) async {
    try {
      await _client.delete("carts/$id");
    } catch (e) {
      Log.d("deleteCart Catch ${e.toString()}");
      return Future.error(e.toString());
    }
  }
}
