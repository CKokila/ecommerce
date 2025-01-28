part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProduct extends ProductEvent {
  final String id;

  FetchProduct({required this.id});
}

class AddToCart extends ProductEvent {
  final String productId;
  final num quantity;

  AddToCart({required this.productId, required this.quantity});
}

final class CartUpdated extends ProductState {}


class UpdateCartQty extends ProductEvent {
  final String productId;
  final num quantity;

  UpdateCartQty({required this.productId, required this.quantity});
}