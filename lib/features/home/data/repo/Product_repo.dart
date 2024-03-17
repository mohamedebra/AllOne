import 'package:all_one/core/helper/chache_helper.dart';
import 'package:all_one/core/networks/api_constants.dart';
import 'package:all_one/features/home/data/model/product_offer.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
      // var response = await apiService.getItems(page, limit);
      // ProductOffers products = response;
      // var box = Hive.box<ProductOffers>(ApiConstants.hiveBoxTypes);
      // box.clear(); // Clear old data
      // box.addAll([products]);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
  Future<List<DataProduct>> fetchProducts({int page = 1, int limit = 10}) async {

    try {

      var response = await apiService.getItems(page, limit);
      List<DataProduct> products = response.data!.data!;

      var box = Hive.box<DataProduct>(ApiConstants.hiveBoxTypes);
      box.clear(); // Clear old data
      box.addAll(products); // Cache new data
      var cachedProducts = box.values.toList();

      // return products;
      return cachedProducts;

    } catch (e) {
      print(e);
      throw Exception('Failed to load products');
    }
  }
  List<DataProduct> parseProducts(dynamic responseBody) {

    var productList = responseBody as List;
    List<DataProduct> products = productList.map<DataProduct>((json) => DataProduct.fromJson(json)).toList();
    return products;
  }



}

class ProductLocal{
  final ApiService apiService = ApiService(Dio());
  ProductLocal();
  final Dio _dio = Dio();
  Future<ApiResult<List<DataProduct>>> fetchProducts({int page = 1, int limit = 10}) async {

    try {

      var response = await apiService.getItems(page, limit);
      List<DataProduct> products = response.data!.data!;

      var box = Hive.box<DataProduct>(ApiConstants.hiveBoxTypes);
      box.clear(); // Clear old data
      box.addAll(products); // Cache new data
      var cachedProducts = box.values.toList();

      // return products;
      return ApiResult.success(cachedProducts);

    } catch (e) {
      print(e);
      throw Exception('Failed to load products');
    }
  }
  List<DataProduct> parseProducts(dynamic responseBody) {

    var productList = responseBody as List;
    List<DataProduct> products = productList.map<DataProduct>((json) => DataProduct.fromJson(json)).toList();
    return products;
  }

}