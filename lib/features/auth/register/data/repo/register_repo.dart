import 'package:all_one/core/networks/api_error_hander.dart';
import 'package:all_one/core/networks/api_service.dart';
import 'package:all_one/features/auth/register/data/models/register_request_body.dart';
import 'package:all_one/features/auth/register/data/models/register_response.dart';
import '../../../../../core/networks/api_result.dart';



class RegisterRepo{
  final ApiService apiService;
  RegisterRepo(this.apiService);

  Future<ApiResult<RegisterResponse>> register(RegisterRequestBody registerRequestBody)async
  {
    try{
      final response = await apiService.register(registerRequestBody);
      return ApiResult.success(response);
    }
    catch(error){
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}