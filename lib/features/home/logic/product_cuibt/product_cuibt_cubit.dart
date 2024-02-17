import 'package:all_one/features/home/logic/product_cuibt/product_cuibt_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/product_offer.dart';
import '../../data/repo/Product_repo.dart';


class ProductCuibtCubit extends Cubit<ProductCuibtState> {
  final ProductRepo productRepo;
  ProductCuibtCubit(this.productRepo) : super(ProductCuibtInitial());
  void fetchProduct() async {
    emit(ProductLoading());
    final result = await productRepo.getProduct();
    result.when(
      success: (types){
        print(types.data);
        emit(ProductSuccess(types));
      },
      failure: (error) =>             emit(ProductError(error.apiErrorModel.message ?? '')),
    );

  }

}
