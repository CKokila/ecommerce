part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeDataLoading extends HomeState {}

class TopProductDataLoaded extends HomeState {
  final List<ProductModel> products;

  TopProductDataLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class DataError extends HomeState {
  final String error;

  DataError({required this.error});
}
