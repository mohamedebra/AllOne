
// class OfferState<T> with _$OfferState<T>{
//   const factory OfferState.init() = _Init;
//
//   const factory OfferState.searchCategories() = SearchCategories;
//
//   const factory OfferState.loading() = Loading;
//
//   const factory OfferState.success(T data) = Success<T>;
//
//   const factory OfferState.onSelectedAdd() = OnSelectedAdd<T>;
//   const factory OfferState.showDialogCityAdd() = ShowDialogCityAdd<T>;
//   const factory OfferState.showDialogCityRemove() = ShowDialogCityRemove<T>;
//
//   const factory OfferState.onSelectedRemove() = OnSelectedRemove<T>;
//
//   const factory OfferState.error({required String error}) = Error;
//
// }

import 'package:all_one/features/home/data/model/product_offer.dart';

import '../../home/data/model/model_products.dart';
import '../../home/data/model/model_types.dart';

abstract class OfferState {}

class OfferInitialState extends OfferState {}

class OfferLoadingState extends OfferState {}

class OfferLoadedState extends OfferState {
  final List<ProductOffers> displayedProducts;
  OfferLoadedState(this.displayedProducts);
}
class OfferLoadedStateTypes extends OfferState {
  final  types;
  OfferLoadedStateTypes(this.types);
}

class OfferErrorState extends OfferState {
  String error;
  OfferErrorState(this.error);
}
class ChangeState extends OfferState {}