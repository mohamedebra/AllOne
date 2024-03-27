
import 'package:all_one/features/home/data/model/product_offer.dart';

import '../data/model/model_country.dart';

abstract class OfferState {}

class OfferInitialState extends OfferState {}

class OfferLoadingState extends OfferState {}

class OffersSuccess extends OfferState {
  final List<DataProduct> products;
  // final List<String> categories;
  // final List<Country> country;
  OffersSuccess(this.products,);
}
class OfferLoadedStateTypes extends OfferState {
}

class OfferErrorState extends OfferState {
  String error;
  OfferErrorState(this.error);
}
class ChangeState extends OfferState {}