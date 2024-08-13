import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> post({
    required body,
    required String url,
    required String token,
    String? contentType,
  }) async {
    final response = _dio.post(
      url,
      data: body,
      options: Options(
        headers: {
          'Content-Type': contentType,
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  }
}
