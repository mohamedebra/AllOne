import 'package:all_one/core/helper/chache_helper.dart';
import 'package:all_one/features/home/data/model/product_offer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/networks/api_error_hander.dart';
import '../../../../core/networks/api_result.dart';
import '../../../../core/networks/api_service.dart';
import '../model/model_types.dart';

class ProductRepo{
  final ApiService apiService;
  ProductRepo(this.apiService);

  Future<ApiResult<ProductOffers>> getProduct({int page = 1, int limit = 10}) async {
    try {
      final response = await apiService.getItems(page, limit);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

}