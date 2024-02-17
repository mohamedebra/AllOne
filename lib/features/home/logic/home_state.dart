
import 'package:all_one/features/home/data/model/product_offer.dart';

import '../data/model/model_types.dart';

abstract class HomeState{}

class HomeInit extends HomeState{}
class HomeLoading extends HomeState{}
class HomeSuccess extends HomeState{}
class HomeError extends HomeState{}
class ChangeNavBar extends HomeState{}

class ChangePosition extends HomeState{}

// Category
class TypesLoading extends HomeState{}
class TypesSuccess extends HomeState{
  Types types;
  TypesSuccess(this.types);
}
class TypesError extends HomeState{
  String error;
  TypesError(this.error);
}

// Product
class ProductLoading extends HomeState{}
class ProductSuccess extends HomeState{
  ProductOffers productOffers;
  ProductSuccess(this.productOffers);
}
class ProductError extends HomeState{
  String error;
  ProductError(this.error);
}