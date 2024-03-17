import 'package:all_one/core/sql/sql_data.dart';
import 'package:all_one/features/home/data/model/model_local/local_model.dart';
import 'package:all_one/features/home/logic/product_cuibt/product_cuibt_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/fanction/fanction.dart';
import '../../../../core/networks/api_constants.dart';
import '../../data/model/product_offer.dart';
import '../../data/repo/Product_repo.dart';


class ProductCuibtCubit extends Cubit<ProductCuibtState> {
  final ProductRepo productRepo;
  ProductCuibtCubit(this.productRepo) : super(ProductCuibtInitial());
  bool hasMoreData = true; // Indicates if there are more data to load
  int _currentPage = 1;
  final int _limit = 10;
  bool isLoading = false;

  List<LocaleModelProduct> listLocal = [];
  void fetchProduct() async {
    if (state is ProductLoading) {

      var db = DatabaseHelper.instance;
      listLocal =await db.queryAllRows();
      emit(ProductLoading(listLocal));
    } // Prevent concurrent fetches

    if (!hasMoreData) {
      return; // Prevent fetching if no more data to load
    }

    if (_currentPage == 1) {
      emit(ProductLoading(listLocal));
      isLoading = true;

    }

    final result = await productRepo.getProduct(page: _currentPage, limit: _limit);
    result.when(
      success: (productOffers) {

        for (var i = 0; i < productOffers.data!.data!.length; i++)

          {
            var db = DatabaseHelper.instance;
            String? title = productOffers.data!.data![i].translations!
                .firstWhere(
                  (title) => title.locale!.endsWith('en'),
            )
                .title;
            int id = productOffers.data!.data![i].id!;
            String imageUrl = productOffers.data!.data![i].files
                ?.firstWhere(
                    (file) =>
                file.image!.endsWith('.jpg') ||
                    file.image!.endsWith('.jpeg') ||
                    file.image!.endsWith('.png'),
                orElse: () => Files(
                    fileType:
                    'asstes/images/2.jpg') // Use orElse to handle the case when no valid image is found.
            )
                .image ?? '';
            int quantity = productOffers.data!.data!.length!;

            db.insert(LocaleModelProduct(
              title: title,
              id: id,
              image: imageUrl,
              quantity: quantity,
            ));
          }
        // List<DataProduct> list =  saveDataLocale(boxname: ApiConstants.hiveBoxTypes,data: result);
        // if(list.isNotEmpty){
        //   emit(ProductSuccess(list));
        // }

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
