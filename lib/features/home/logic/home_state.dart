
import 'package:all_one/features/home/data/model/product_offer.dart';

import '../data/model/model_local/local_model.dart';
import '../data/model/model_types.dart';

abstract class HomeState{}

class HomeInit extends HomeState{}
class HomeLoading extends HomeState{}
class HomeSuccess extends HomeState{}
class HomeError extends HomeState{}
class ChangeNavBar extends HomeState{}

class ChangePosition extends HomeState{}

// Category
class TypesLoading extends HomeState{
  List<LocaleModelProduct> local;
  TypesLoading(this.local);

}
class TypesSuccess extends HomeState{
  List<Data> types;
  TypesSuccess(this.types);
}
class TypesError extends HomeState{
  String error;
  TypesError(this.error);
}

// Product
class ProductLoading extends HomeState{
  List<LocaleModelProduct> local;
  ProductLoading(this.local);

}
class ProductSuccess extends HomeState{
  ProductOffers productOffers;
  ProductSuccess(this.productOffers);
}
class ProductError extends HomeState{
  String error;
  ProductError(this.error);
}