import 'package:all_one/features/home/data/model/model_types.dart';
import 'package:hive/hive.dart';

import '../../../../core/fanction/fanction.dart';
import '../../../../core/networks/api_constants.dart';
import '../../../../core/networks/api_error_hander.dart';
import '../../../../core/networks/api_result.dart';
import '../../../../core/networks/api_service.dart';
import '../model/product_offer.dart';
import '../test.dart';

class TypesRepo{
  final ApiService apiService;
  TypesRepo(this.apiService);


  Future<ApiResult<Types>> getTypes() async {
    try {

      final types = await apiService.getTypes();
      print(types);



      return ApiResult.success(types);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

// Future<ApiResult<Types>> getTypes()async
  // {
  //   try{
  //     final response = await apiService.getTypes();
  //     print(response);
  //     Types tabBaModel = Types.fromJson(response.toJson());
  //     return ApiResult.success(tabBaModel);
  //   }
  //   catch(error){
  //     return ApiResult.failure(ErrorHandler.handle(error));
  //   }
  // }
  // Future<ApiResult<Types>> fetchNewsetBooks() async {
  //   try{
  //     final response = await getType!.get();
  //     print(response);
  //
  //     Types tabBaModel = Types.fromJson(response);
  //     print(tabBaModel);
  //
  //     return ApiResult.success(tabBaModel);
  //   }
  //   catch(error){
  //     return ApiResult.failure(ErrorHandler.handle(error));
  //   }
  // }

// Future<ApiResult<List<Types>>> fetchTypes() async {
  //   try {
  //     var response = await apiService.getTypes();
  //     // Assuming response is a List<dynamic> or similar
  //     List<Types> books = response.map((item) => Types.fromJson(item as Map<String, dynamic>)).toList();
  //
  //     return ApiResult.success(books);
  //   } catch (e) {
  //     // Log the error or handle it as needed
  //     print('Error fetching newest books: $e');
  //     return ApiResult.failure(ErrorHandler.handle(e));
  //   }
  // }
}