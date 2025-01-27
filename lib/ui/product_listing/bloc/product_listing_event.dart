part of 'product_listing_bloc.dart';

@immutable
sealed class ProductListingEvent {}

class FetchProduct extends ProductListingEvent {
  final String category;
  final String? sort;

  FetchProduct({required this.category,this.sort});
}
