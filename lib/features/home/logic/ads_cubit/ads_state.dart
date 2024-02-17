part of 'ads_cubit.dart';

@immutable
abstract class AdsState {}

class AdsInitial extends AdsState {}
class AdsLoading extends AdsInitial{}
class AdsTrue extends AdsInitial{}
class AdsFalse extends AdsInitial{}
class AdsSuccess extends AdsInitial{
  AdsModel adsModel;
  AdsSuccess(this.adsModel);
}
class AdsError extends AdsInitial{
  String error;
  AdsError(this.error);
}