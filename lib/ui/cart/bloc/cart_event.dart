part of 'cart_bloc.dart';

sealed class CartEvent {}

class FetchCart extends CartEvent {}

class UpdateCart extends CartEvent {
  final num cartId;
  final List<ProductCart> products;

  UpdateCart({required this.cartId, required this.products});
}

class DeleteCart extends CartEvent {
  final num cartId;

  DeleteCart({required this.cartId});
}

class ClearCart extends CartEvent {
  final num cartId;

  ClearCart({required this.cartId});
}
