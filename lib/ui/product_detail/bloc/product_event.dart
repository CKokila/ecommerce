part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProduct extends ProductEvent {
  final String id;

  FetchProduct({required this.id});
}
