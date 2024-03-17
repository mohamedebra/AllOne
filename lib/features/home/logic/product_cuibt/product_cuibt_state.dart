
import '../../data/model/model_local/local_model.dart';
import '../../data/model/product_offer.dart';

abstract class ProductCuibtState {}

class ProductCuibtInitial extends ProductCuibtState {}
class ProductLoading extends ProductCuibtState{
  List<LocaleModelProduct> local;
  ProductLoading(this.local);

}
class PaginationProductLoading extends ProductCuibtState{}
class Current extends ProductCuibtState{}
class ProductSuccess extends ProductCuibtState{
  List<DataProduct> productOffers;
  ProductSuccess(this.productOffers);
}
class ProductError extends ProductCuibtState{
  String error;
  ProductError(this.error);
}