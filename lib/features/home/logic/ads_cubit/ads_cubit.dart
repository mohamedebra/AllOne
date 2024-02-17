import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/ads/ads_model.dart';
import '../../data/repo/Product_repo.dart';
import '../../data/repo/repo_ads.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit(this.ads) : super(AdsInitial());
  final RepoAds ads;

  void fetchAds() async {
    emit(AdsLoading());
    final result = await ads.getAds();
    result.when(
      success: (types) => emit(AdsSuccess(types)),
      failure: (error) =>             emit(AdsError(error.apiErrorModel.message ?? '')),
    );

  }

  bool isClose = true;

  void changeCloseTrue(){
    isClose = false ;
    emit(AdsFalse());
  }
  void changeCloseFalse(){
    isClose = true ;
    emit(AdsTrue());
  }

}
