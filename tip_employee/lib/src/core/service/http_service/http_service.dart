import 'package:dio/dio.dart';
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
          followRedirects: false, // important for Laravel 302 redirects
          validateStatus: (status) => status != null && status < 500, // accept 200–499
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

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
    // If Laravel redirected (302), body may not be JSON, so fallback
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
