import 'package:bloc/bloc.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/data/repo/product_repo.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepo productRepo = ProductRepo();

  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>(_fetchTopProduct);
  }

  Future<void> _fetchTopProduct(
      FetchProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      var response = await productRepo.getProduct(event.id);
      emit(ProductLoaded(product: response));
    } catch (error) {
      emit(DataError(error: error.toString()));
    }
  }
}
