import 'package:dio/dio.dart';
import 'package:video_player_app/core/services/api/api_service.dart';
import 'package:video_player_app/core/services/api/dio_interceptor.dart';
import 'package:video_player_app/core/utils/constants.dart';

class ApiServiceImpl implements ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: Constants.baseUrl),
  )..interceptors.add(DioInterceptor());

  @override
  Future get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final request = await _dio.get(
        endpoint,
        queryParameters: params ?? {},
      );
      if (request.statusCode! >= 200 && request.statusCode! < 300) {
        return request.data;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return e.response;
      }
      return e.response!.statusCode;
    }
  }
}
