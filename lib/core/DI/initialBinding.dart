import 'package:all_one/controller/offers_controoler.dart';
import 'package:all_one/features/home/data/repo/repo_types.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../features/home/data/repo/Product_repo.dart';
import '../networks/api_service.dart';

class InitialBinding implements Bindings{
  @override
  void dependencies() {
    // Get.put(() => OfferController(ProductRepo(ApiService(Dio())),TypesRepo(ApiService(Dio()))));


  }

}

