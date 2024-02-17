import 'package:all_one/core/networks/api_error_hander.dart';
import 'package:all_one/core/networks/api_service.dart';
import 'package:all_one/features/home/data/model/model_products.dart';


import '../../../../../core/networks/api_result.dart';
import '../../../home/data/model/model_types.dart';
import '../../../home/data/model/product_offer.dart';
import '../model/model_country.dart';

class OfferRepo{
  final ApiService apiService;

  OfferRepo(this.apiService);



  Future<ApiResult<ProductOffers>> getProduct() async {
    // try {
    //   final product = await apiService.getItems();
    //   print(product);
    //   return ApiResult.success(product);
    // } catch (error) {
    //   return ApiResult.failure(ErrorHandler.handle(error));
    // }
    try {
      final response = await apiService.getItems(); // Ensure this returns List<Post>
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  Future<ApiResult<CountryApi>> getCountry() async {
    try {
      final response = await apiService.getCountry(); // Ensure this returns List<Post>
      List<CountryApi> country = [];
      country.add(CountryApi.fromJson(response.toJson()));
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  Future<ApiResult<Types>> getTypes() async {
    // try {
    //   final product = await apiService.getItems();
    //   print(product);
    //   return ApiResult.success(product);
    // } catch (error) {
    //   return ApiResult.failure(ErrorHandler.handle(error));
    // }
    try {
      final response = await apiService.getTypes(); // Ensure this returns List<Post>
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  Future<ApiResult<List<ProductOffers>>> getTypesList() async {

    try {
      final response = await apiService.getTypes(); // Ensure this returns List<Post>
      List<ProductOffers> country = [];
      country.add(ProductOffers.fromJson(response.toJson()));
      return ApiResult.success(country);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

}