import 'package:all_one/features/home/data/model/product_offer.dart';

import '../../../../core/networks/api_service.dart';
import '../model/note_model.dart';
import '../../../../core/networks/api_error_hander.dart';
import '../../../../core/networks/api_result.dart';
class NoteRepo{
  final ApiService apiService;
  NoteRepo(this.apiService);

  Future<ApiResult<ProductOffersA>> getProduct() async {
    // try {
    //   final product = await apiService.getItems();
    //   print(product);
    //   return ApiResult.success(product);
    // } catch (error) {
    //   return ApiResult.failure(ErrorHandler.handle(error));
    // }
    try {
      final response = await apiService.getNotification(); // Ensure this returns List<Post>

      return ApiResult.success(response);

    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }


}