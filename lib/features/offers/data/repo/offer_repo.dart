import 'package:all_one/core/networks/api_error_hander.dart';
import 'package:all_one/core/networks/api_service.dart';
import '../../../../../core/networks/api_result.dart';
import '../../../home/data/model/model_types.dart';
import '../../../home/data/model/product_offer.dart';
import '../model/model_country.dart';

class OfferRepo{
  final ApiService apiService;

  OfferRepo(this.apiService);



  Future<CountryApi> getCountry() async {
    final response = await apiService.getCountry(); // Ensure this returns List<Post>

    return response;
  }
  Future<ProductOffers> getProduct({int page = 1, int limit = 10}) async {
    final response = await apiService.getItems(page, limit);
    return response;
  }



}