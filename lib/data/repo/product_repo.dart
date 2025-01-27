import 'package:ecommerce/data/api/api_server.dart';
import 'package:ecommerce/data/model/product_model.dart';

import '../../utils/log.dart';
import '../api/api_response.dart';

class ProductRepo {
  final DioClient _client = DioClient();

  Future<List<ProductModel>> getProducts(String category,
      {String? sort}) async {
    List<ProductModel> productResponse;
    try {
      String pathParam = (sort != null) ? "?sort=$sort" : "";
      ApiResponse response = await _client
          .get("products/category/${category.toLowerCase()}$pathParam");
      var data = response.data;
      productResponse =
          List<ProductModel>.from(data.map((e) => ProductModel.fromJson(e)));
      return productResponse;
    } catch (e) {
      Log.d("Response product Catch${e.toString()}");
      return Future.error(e.toString());
    }
  }

  Future<ProductModel> getProduct(String id) async {
    ProductModel productResponse;
    try {
      ApiResponse response = await _client.get("products/$id");
      var data = response.data;
      productResponse = ProductModel.fromJson(data);
      return productResponse;
    } catch (e) {
      Log.d("getProduct Catch ${e.toString()}");
      return Future.error(e.toString());
    }
  }

  Future<List<ProductModel>> searchProduct(String keyword) async {
    List<ProductModel> productResponse;
    try {
      ApiResponse response = await _client.get("products");
      var data = response.data;
      productResponse =
          List<ProductModel>.from(data.map((e) => ProductModel.fromJson(e)));
      List<ProductModel> list = productResponse
          .where((e) => e.title!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      return list;
    } catch (e) {
      Log.d("Response product Catch${e.toString()}");
      return Future.error(e.toString());
    }
  }

  Future<List<ProductModel>> getTopSelling() async {
    List<ProductModel> productResponse;
    try {
      ApiResponse response = await _client.get("products?limit=5");
      var data = response.data;
      productResponse =
          List<ProductModel>.from(data.map((e) => ProductModel.fromJson(e)));
      return productResponse;
    } catch (e) {
      Log.d("Response product Catch${e.toString()}");
      return Future.error(e.toString());
    }
  }
}
