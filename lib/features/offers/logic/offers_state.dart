
import 'package:all_one/features/home/data/model/product_offer.dart';

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