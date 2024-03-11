class ApiConstants{
  // static const String apiBaseUrlR = 'https://vcare.integration25.com/api/';



  static const String apiBaseUrl = 'http://app.misrgidda.com/api/';
  static const String types = 'types';
  static const String items = 'items';
  static const String country = 'categories';
  static const String ads = 'static_banners';
  static const String notification = 'notification';
  static const String login = 'user/login';
  static const String register = 'createuser';

  static const String hiveBoxTypes = 'hiveBoxTypes';


}
class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}