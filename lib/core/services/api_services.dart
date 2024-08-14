import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> post({
    required body,
    required String url,
    required String token,
    String? contentType,
    Map<String, String>? headers,
  }) async {
    final response = _dio.post(
      url,
      data: body,
      options: Options(
        headers: headers ??
            {
              'Content-Type': contentType,
              'Authorization': 'Bearer $token',
            },
      ),
    );
    return response;
  }
}
