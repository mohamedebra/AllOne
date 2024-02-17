import 'package:dio/dio.dart';

class GetTypes{
  final _baseUrl = 'http://app.misrgidda.com/api/';
  final Dio _dio;

  GetTypes(this._dio);

  Future<Map<String, dynamic>> get() async {
    var response = await _dio.get('${_baseUrl}types');
    return response.data;
  }

}