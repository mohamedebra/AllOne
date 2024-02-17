import '../../../../core/networks/api_error_hander.dart';
import '../../../../core/networks/api_result.dart';
import '../../../../core/networks/api_service.dart';
import '../model/ads/ads_model.dart';

class RepoAds{
  final ApiService apiService;
  RepoAds(this.apiService);

  Future<ApiResult<AdsModel>> getAds() async {
    try {
      final response = await apiService.getAds(); // Ensure this returns List<Post>
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }


}