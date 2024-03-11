import 'package:all_one/core/networks/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/auth/login/data/models/login_request_body.dart';
import '../../features/auth/login/data/models/login_response.dart';
import '../../features/auth/register/data/models/register_request_body.dart';
import '../../features/auth/register/data/models/register_response.dart';
import '../../features/home/data/model/ads/ads_model.dart';
import '../../features/home/data/model/model_types.dart';
import '../../features/home/data/model/product_offer.dart';
import '../../features/notification/data/model/note_model.dart';
import '../../features/offers/data/model/model_country.dart';


part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(
    Dio dio, {
    String baseUrl,
  }) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );
  @POST(ApiConstants.register)
  Future<RegisterResponse> register(
      @Body() RegisterRequestBody registerRequestBody);

  @GET(ApiConstants.types)
  Future<Types> getTypes();


  @GET(ApiConstants.items,)
  Future<ProductOffers> getItems(@Query("page") int page, @Query("limit") int limit);
  @GET(ApiConstants.country)
  Future<CountryApi> getCountry();

  @GET(ApiConstants.ads)
  Future<AdsModel> getAds();

  @GET(ApiConstants.notification)
  Future<ProductOffersA> getNotification();
}
