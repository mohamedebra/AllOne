import 'package:all_one/features/home/logic/product_cuibt/product_cuibt_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/product_offer.dart';
import '../../data/repo/Product_repo.dart';


class ProductCuibtCubit extends Cubit<ProductCuibtState> {
  final ProductRepo productRepo;
  ProductCuibtCubit(this.productRepo) : super(ProductCuibtInitial());
  bool hasMoreData = true; // Indicates if there are more data to load
  int _currentPage = 1;
  final int _limit = 10;
  bool isLoading = false;

  void fetchProduct() async {
    if (state is ProductLoading) return; // Prevent concurrent fetches

    if (!hasMoreData) {
      return; // Prevent fetching if no more data to load
    }

    if (_currentPage == 1) {
      emit(ProductLoading());
      isLoading = true;

    }

    final result = await productRepo.getProduct(page: _currentPage, limit: _limit);
    result.when(
      success: (productOffers) {
        if (productOffers.data!.data!.isEmpty || productOffers.data!.data!.length < _limit) {
          hasMoreData = false; // No more data to load
        }

        if (_currentPage == 1) {
          emit(ProductSuccess(productOffers.data!.data!));
        } else {
          // Append the new data if it's a subsequent page
          final currentState = state as ProductSuccess;
          final updatedList = currentState.productOffers + productOffers.data!.data!;
          isLoading = false;
          emit(ProductSuccess(updatedList));

        }
        _currentPage++; // Prepare for next page fetch

      },
      failure: (error) => emit(ProductError(error.apiErrorModel.message ?? '')),
    );
  }
  void resetAndFetchProduct() {
    _currentPage = 1;
    hasMoreData = true;
    fetchProduct();
  }
  // Call this method to load the next page
  void loadNextPage() {
    if (hasMoreData && state is! ProductLoading) {
      print(_currentPage);
      fetchProduct();
    }
  }
  void current() {
    _currentPage++; // Prepare for next page fetch
    emit(Current());
  }
}
