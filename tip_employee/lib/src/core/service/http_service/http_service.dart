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

  HttpServiceImpl({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )) {
    // Interceptor to log requests and responses
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        print('--- HTTP REQUEST ---');
        print('URL: ${options.uri}');
        print('Method: ${options.method}');
        print('Headers: ${options.headers}');
        print('Body: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('--- HTTP RESPONSE ---');
        print('Status: ${response.statusCode}');
        print('Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print('--- HTTP ERROR ---');
        print('Error: ${e.message}');
        if (e.response != null) {
          print('Status: ${e.response?.statusCode}');
          print('Data: ${e.response?.data}');
        }
        return handler.next(e);
      },
    ));
  }

  @override
  Future<HttpServiceResponseModel> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(url, options: Options(headers: headers));
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpServiceResponseModel> post(String url, dynamic data, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.post(url, data: data, options: Options(headers: headers));
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpServiceResponseModel> put(String url, dynamic data, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.put(url, data: data, options: Options(headers: headers));
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<HttpServiceResponseModel> delete(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.delete(url, options: Options(headers: headers));
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleError(e);
    }
  }

  HttpServiceResponseModel _handleResponse(Response response) {
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
    return HttpServiceResponseModel(
      staticCode: e.response?.statusCode ?? 500,
      data: {
        'error': e.message,
        'details': e.response?.data,
      },
    );
  }
}
