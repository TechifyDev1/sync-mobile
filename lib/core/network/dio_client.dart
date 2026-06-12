import 'dart:developer' as dev;

import 'package:dio/dio.dart';

import '../storage/hive/hive_storage.dart';
import '../storage/hive/models/tokens.dart';
import 'api_endpoints.dart';
import 'app_error.dart';

class DioClient {
  final Dio _dio;
  final HiveStorage _hiveStorage;
  DioClient._internal() : _dio = Dio(), _hiveStorage = HiveStorage() {
    _dio.options = _options;
    _dio.interceptors.addAll([_interceptor, LogInterceptor()]);
  }

  bool _hasRefreshed = false;
  late final Interceptor _interceptor = InterceptorsWrapper(
    onRequest: (options, handler) {
      final tokens =
          _hiveStorage.get(boxName: "auth_box", keyName: "tokens")
              as Map<String, String>;
      final parsedTokens = Tokens.fromJson(tokens);
      final accessToken = parsedTokens.accessToken;
      options.headers["Authorization"] = "Bearer $accessToken";
      return handler.next(options);
    },
    onError: (error, handler) async {
      final statusCode = error.response?.statusCode;
      if (statusCode != null && statusCode == 401 && !_hasRefreshed) {
        try {
          await _performTokenRefresh();
          final tokens =
              _hiveStorage.get(boxName: "auth_box", keyName: "tokens")
                  as Map<String, String>;
          final parsedTokens = Tokens.fromJson(tokens);
          final requestOptions = error.requestOptions;
          requestOptions.headers["Authorization"] =
              "Bearer ${parsedTokens.accessToken}";
          final res = await _dio.fetch(requestOptions);
          if (res.statusCode != 200) {
            _hasRefreshed = true;
            return handler.reject(
              DioException(
                requestOptions: requestOptions,
                response: res,
                type: .badResponse,
                error: AppError.fromJson(res.data),
              ),
            );
          }
          _hasRefreshed = false;
          return handler.resolve(res);
        } catch (e) {
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: AppError(
                title: "Authentication error",
                message: "Unable to refresh token",
                status: 401,
                timeStamp: DateTime.now().toIso8601String(),
              ),
              type: .unknown,
              message: "Authentication refresh workflow failed.",
            ),
          );
        }
      }

      if (error.response != null &&
          error.response!.data is Map<String, dynamic>) {
        final customException = DioException(
          requestOptions: error.requestOptions,
          response: error.response,
          type: error.type,
          error: AppError.fromJson(error.response!.data),
        );
        return handler.reject(customException);
      }

      if (error.type == .connectionTimeout) {
        final timeOutError = DioException(
          requestOptions: error.requestOptions,
          error: AppError(
            title: "Time out",
            message:
                "Connection timed out, please check your internet connection",
            status: 0,
            timeStamp: DateTime.now().toIso8601String(),
          ),
        );
        return handler.next(timeOutError);
      }

      return handler.next(error);
    },
  );

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  final BaseOptions _options = BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    contentType: "application/json",
    connectTimeout: Duration(seconds: 20),
    receiveTimeout: Duration(seconds: 20),
  );

  Future<dynamic> get({required String url, dynamic body}) async {
    return await _dio.get(url, data: body);
  }

  Future<dynamic> post({required String url, dynamic body}) async {
    return await _dio.post(url, data: body);
  }

  Future<void> _performTokenRefresh() async {
    try {
      final res = await post(url: ApiEndpoints.refreshTokens);
      if (res.statusCode == 200) {
        final data = res.data as Map<String, String>;
        final tokens = Tokens.fromJson(data);
        await _hiveStorage.save(
          boxName: "auth_box",
          keyName: "tokens",
          data: tokens.toJson(),
        );
        return;
      }
    } catch (e) {
      dev.log("Token refresh failed ${e.toString()}");
      rethrow;
    }
  }
}
