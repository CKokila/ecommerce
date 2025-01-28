class CartModel {
  num? id;
  num? userId;
  String? date;
  List<ProductCart>? products;
  num? iV;

  num get subTotal {
    if (products == null || products!.isEmpty) {
      return 0;
    }
    return products!
        .fold(0, (total, product) => total + (product.totalPrice ?? 0));
  }

  num get deliveryFee => 25;
  num get discount => 0;

  num get total => subTotal + deliveryFee;

  CartModel({this.id, this.userId, this.date, this.products, this.iV});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      products = <ProductCart>[];
      json['products'].forEach((v) {
        products!.add(ProductCart.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class ProductCart {
  num? productId;
  num? quantity;
  String? category;
  String? image;
  String? title;
  num? totalPrice;

  ProductCart(
      {this.productId,
      this.quantity,
      this.category,
      this.title,
      this.image,
      this.totalPrice});

  ProductCart.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
