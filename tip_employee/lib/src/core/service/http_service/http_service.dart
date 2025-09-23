import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_service_response_model.dart';

abstract interface class HttpService {
  Future<HttpServiceResponseModel> get(String url, {Map<String, String>? headers});
  Future<HttpServiceResponseModel> post(String url, dynamic data, {Map<String, String>? headers});
  Future<HttpServiceResponseModel> put(String url, dynamic data, {Map<String, String>? headers});
  Future<HttpServiceResponseModel> delete(String url, {Map<String, String>? headers});
}

class HttpServiceImpl implements HttpService {
  final Dio _dio;

  HttpServiceImpl({Dio? dio, String baseUrl = 'https://4bd229d2ff23.ngrok-free.app'})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                followRedirects: false,
                validateStatus: (status) => status != null && status < 500,
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            )..interceptors.add(
                LogInterceptor(
                  requestHeader: true,
                  requestBody: true,
                  responseHeader: true,
                  responseBody: true,
                  error: true,
                  logPrint: (obj) => print('[DIO DEBUG] $obj'),
                ),
              );

  Future<Options> _withAuthHeaders(Map<String, String>? headers) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('🛠 AUTH TOKEN: $token');

    final authHeader = token != null ? {'Authorization': 'Bearer $token'} : {};

    return Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
        ...authHeader,
      },
    );
  }

  @override
  Future<HttpServiceResponseModel> get(String url, {Map<String, String>? headers}) async {
    try {
      final options = await _withAuthHeaders(headers);
      final response = await _dio.get(url, options: options);
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpServiceResponseModel> post(String url, dynamic data, {Map<String, String>? headers}) async {
    try {
      final options = await _withAuthHeaders(headers);
      final response = await _dio.post(url, data: data, options: options);
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpServiceResponseModel> put(String url, dynamic data, {Map<String, String>? headers}) async {
    try {
      final options = await _withAuthHeaders(headers);
      final response = await _dio.put(url, data: data, options: options);
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpServiceResponseModel> delete(String url, {Map<String, String>? headers}) async {
    try {
      final options = await _withAuthHeaders(headers);
      final response = await _dio.delete(url, options: options);
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  HttpServiceResponseModel _handleResponse(Response response) {
    print('🔹 RESPONSE [${response.statusCode}] ${response.requestOptions.method} ${response.requestOptions.path}');
    print('🔹 RESPONSE DATA: ${response.data}');

    dynamic body = response.data;

    if (response.statusCode == 302 && body is String) {
      body = {'redirect_url': response.headers.value('location') ?? ''};
    }

    return HttpServiceResponseModel(
      staticCode: response.statusCode ?? 500,
      data: body,
    );
  }

  HttpServiceResponseModel _handleError(DioError e) {
    print('❌ ERROR [${e.response?.statusCode ?? 'NO STATUS'}] ${e.requestOptions.method} ${e.requestOptions.path}');
    print('❌ ERROR MESSAGE: ${e.message}');
    print('❌ RESPONSE DATA: ${e.response?.data}');

    return HttpServiceResponseModel(
      staticCode: e.response?.statusCode ?? 500,
      data: {
        'error': e.message,
        'details': e.response?.data,
      },
    );
  }
}
