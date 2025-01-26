import 'package:bloc/bloc.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/data/repo/product_repo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ProductRepo productRepo = ProductRepo();

  HomeBloc() : super(HomeInitial()) {
    on<FetchTopProductDataEvent>(_fetchTopProduct);
  }

  Future<void> _fetchTopProduct(
      FetchTopProductDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeDataLoading());
    try {
      var response = await productRepo.getTopSelling();
      response.sort((a,b) => (a.rating?.rate ?? 0).compareTo(b.rating?.rate ?? 0));
      emit(TopProductDataLoaded(products: response.reversed.toList()));
    } catch (error) {
      emit(DataError(error: error.toString()));
    }
  }
}
