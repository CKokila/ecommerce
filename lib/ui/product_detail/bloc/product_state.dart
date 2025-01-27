part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final ProductModel product;

  ProductLoaded({required this.product});
}

final class DataError extends ProductState {
  final String error;

  DataError({required this.error});
}
