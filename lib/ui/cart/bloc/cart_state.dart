part of 'cart_bloc.dart';


sealed class CartState {}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final CartModel cart;

  CartLoaded({required this.cart});
}
class CartUpdated extends CartState {
  final CartModel cart;
  CartUpdated({required this.cart});
}

class CartDeleted extends CartState {}

class CartCleared extends CartState {}

final class CartError extends CartState {
  final String error;

  CartError({required this.error});
}