import 'package:bloc/bloc.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repo/product_repo.dart';

part 'product_listing_event.dart';

part 'product_listing_state.dart';

class ProductListingBloc
    extends Bloc<ProductListingEvent, ProductListingState> {
  ProductRepo productRepo = ProductRepo();

  ProductListingBloc() : super(ProductListingInitial()) {
    on<FetchProduct>(_fetchTopProduct);
  }

  Future<void> _fetchTopProduct(
      FetchProduct event, Emitter<ProductListingState> emit) async {
    emit(ProductListingLoading());
    try {
      var response = await productRepo.getProducts(event.category,sort: event.sort);
      emit(ProductListingLoaded(productList: response.reversed.toList()));
    } catch (error) {
      emit(DataError(error: error.toString()));
    }
  }
}
