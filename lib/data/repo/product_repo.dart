import 'package:ecommerce/data/api/api_server.dart';
import 'package:ecommerce/data/model/product_model.dart';

import '../../utils/log.dart';
import '../api/api_response.dart';

class ProductRepo {
  final DioClient _client = DioClient();

  Future<List<ProductModel>> getProducts(String keyword) async {
    List<ProductModel> productResponse;
    try {
      ApiResponse response = await _client.get("products");
      var data = response.data;
      productResponse =
          List<ProductModel>.from(data.map((e) => ProductModel.fromJson(e)));
      return productResponse;
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
