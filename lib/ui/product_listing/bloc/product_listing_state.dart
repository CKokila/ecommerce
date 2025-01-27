part of 'product_listing_bloc.dart';

@immutable
sealed class ProductListingState {}

final class ProductListingInitial extends ProductListingState {}

final class ProductListingLoading extends ProductListingState {}

final class ProductListingLoaded extends ProductListingState {
  final List<ProductModel> productList;

  ProductListingLoaded({required this.productList});
}
class DataError extends ProductListingState {
  final String error;

  DataError({required this.error});
}
