
import '../../data/model/product_offer.dart';

abstract class ProductCuibtState {}

class ProductCuibtInitial extends ProductCuibtState {}
class ProductLoading extends ProductCuibtState{}
class ProductSuccess extends ProductCuibtState{
  ProductOffers productOffers;
  ProductSuccess(this.productOffers);
}
class ProductError extends ProductCuibtState{
  String error;
  ProductError(this.error);
}