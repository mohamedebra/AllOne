import 'package:dio/dio.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_interceptors.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;
  // late CacheStore cacheStore;
  // late CacheOptions cacheOptions;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {

    // DioCacheInterceptor dioCacheInterceptor =   DioCacheInterceptor(options: CacheOptions(
    //     hitCacheOnErrorExcept: [],
    //     store: MemCacheStore(maxEntrySize: 10485760 ,maxSize: 10485760)));
    // DefaultCacheManager cacheManager = DefaultCacheManager();

    dio?.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),);
    dio?.interceptors.add(ApiInterceptor());
    // dio?..interceptors.add(dioCacheInterceptor);

  }
}
