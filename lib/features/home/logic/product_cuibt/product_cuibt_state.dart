
import '../../data/model/product_offer.dart';

abstract class ProductCuibtState {}

class ProductCuibtInitial extends ProductCuibtState {}
class ProductLoading extends ProductCuibtState{}
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