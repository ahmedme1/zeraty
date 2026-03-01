import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class DioHelper {
  static late Dio dio;
  static BuildContext? context;

  static final Map<String, int> _errorCounter = {};
  static final Map<String, DateTime> _lastErrorShown = {};
  static const Duration _errorCooldown = Duration(seconds: 8);
  static const int _maxErrorsBeforeHide = 3;

  static const int _maxRetries = 2;
  static const Duration _retryDelay = Duration(milliseconds: 1500);

  static int _consecutiveFailures = 0;
  static bool _isOfflineMode = false;
  static DateTime? _offlineModeStarted;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 120),
        sendTimeout: const Duration(seconds: 120),
        validateStatus: (status) => status! < 600,
      ),
    );

    dio.httpClientAdapter = IOHttpClientAdapter()
      ..createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };

    dio.interceptors.addAll([
      SmartNetworkInterceptor(),
      RetryInterceptor(dio),
      if (kDebugMode)
        LogInterceptor(
          requestBody: false,
          responseBody: false,
          error: true,
          logPrint: (obj) {
            if (!obj.toString().contains('SlowSQLite')) {
              debugPrint(obj.toString());
            }
          },
        ),
    ]);
  }

  static Map<String, dynamic> _getHeaders({required bool sendAuthToken}) {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      if (sendAuthToken) "Authorization": 'Bearer ${CacheKeysManger.getUserTokenFromCache()}',
    };
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
    bool showErrors = true,
    bool enableRetry = true,
    bool silent = false,
  }) async {
    return _executeRequest(
      () => dio.get(
        url,
        queryParameters: query,
        options: Options(
          headers: _getHeaders(sendAuthToken: sendAuthToken),
          extra: {
            'showErrors': showErrors && !silent,
            'enableRetry': enableRetry,
            'silent': silent,
          },
        ),
      ),
      showErrors: showErrors && !silent,
      silent: silent,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
    bool showErrors = true,
    bool enableRetry = false,
    bool silent = false,
    void Function(int sent, int total)? onProgress,
  }) async {
    return _executeRequest(
      () => dio.post(
        url,
        queryParameters: query,
        data: data,
        onSendProgress: onProgress,
        options: Options(
          headers: _getHeaders(sendAuthToken: sendAuthToken),
          extra: {
            'showErrors': showErrors && !silent,
            'enableRetry': enableRetry,
            'silent': silent,
          },
        ),
      ),
      showErrors: showErrors && !silent,
      silent: silent,
    );
  }

  static Future<Response> postForm({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
    bool showErrors = true,
    bool silent = false,
    void Function(int sent, int total)? onProgress,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) async {
    return _executeRequest(
      () => dio.post(
        url,
        data: data,
        queryParameters: query,
        onSendProgress: onProgress,

        options: Options(
          headers: _getHeaders(sendAuthToken: sendAuthToken),
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
          followRedirects: false,
          extra: {'showErrors': showErrors && !silent, 'enableRetry': false, 'silent': silent},
        ),
      ),
      showErrors: showErrors && !silent,
      silent: silent,
    );
  }

  static Future<Response> updateForm({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
    bool showErrors = true,
    bool silent = false,
    void Function(int sent, int total)? onProgress,
  }) async {
    return _executeRequest(
      () => dio.post(
        url,
        data: data,
        queryParameters: query,
        onSendProgress: onProgress,
        options: Options(
          headers: {
            "Accept": "application/json",
            if (sendAuthToken) "Authorization": 'Bearer ${CacheKeysManger.getUserTokenFromCache()}',
          },
          extra: {'showErrors': showErrors && !silent, 'enableRetry': false, 'silent': silent},
        ),
      ),
      showErrors: showErrors && !silent,
      silent: silent,
    );
  }

  static Future<Response> updateData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
    bool showErrors = true,
    bool silent = false,
  }) async {
    return _executeRequest(
      () => dio.put(
        url,
        queryParameters: query,
        data: data,
        options: Options(
          headers: _getHeaders(sendAuthToken: sendAuthToken),
          extra: {'showErrors': showErrors && !silent, 'silent': silent},
        ),
      ),
      showErrors: showErrors && !silent,
      silent: silent,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
    bool showErrors = true,
    bool silent = false,
  }) async {
    return _executeRequest(
      () => dio.delete(
        url,
        queryParameters: query,
        data: data,
        options: Options(
          headers: _getHeaders(sendAuthToken: sendAuthToken),
          extra: {'showErrors': showErrors && !silent, 'silent': silent},
        ),
      ),
      showErrors: showErrors && !silent,
      silent: silent,
    );
  }

  static Future<Response> _executeRequest(
    Future<Response> Function() request, {
    required bool showErrors,
    required bool silent,
  }) async {
    try {
      final response = await request();

      if (_consecutiveFailures > 0) {
        _consecutiveFailures = 0;
        _isOfflineMode = false;
        _offlineModeStarted = null;
        _showSuccessAfterOffline();
      }

      return response;
    } catch (e) {
      if (!silent) {
        _consecutiveFailures++;

        if (_consecutiveFailures >= 3 && !_isOfflineMode) {
          _isOfflineMode = true;
          _offlineModeStarted = DateTime.now();
          _showSmartError(
            'offline_mode',
            '📵 فُقد الاتصال'.tr,
            duration: const Duration(seconds: 3),
          );
        }
      }

      rethrow;
    }
  }

  static void _showSuccessAfterOffline() {
    if (_offlineModeStarted != null) {
      final duration = DateTime.now().difference(_offlineModeStarted!);
      if (duration.inSeconds > 5) {
        CustomSnackbar.success('✅ عاد الاتصال بالإنترنت'.tr);
      }
    }
  }

  static void _showSmartError(
    String errorKey,
    String message, {
    String? description,
    Duration duration = const Duration(seconds: 2),
  }) {
    final now = DateTime.now();

    _errorCounter[errorKey] = (_errorCounter[errorKey] ?? 0) + 1;

    if (_errorCounter[errorKey]! > _maxErrorsBeforeHide) {
      return;
    }

    final lastShown = _lastErrorShown[errorKey];
    if (lastShown == null || now.difference(lastShown) > _errorCooldown) {
      _lastErrorShown[errorKey] = now;

      if (description != null) {
        CustomSnackbar.warning(description);
      } else {
        CustomSnackbar.warning(description!);
      }
      if (_errorCounter[errorKey] == _maxErrorsBeforeHide) {
        Future.delayed(duration, () {
          CustomSnackbar.info('💡 سيتم إخفاء التنبيهات المتكررة'.tr);
        });
      }
    }
  }

  static void handleStatusCode(int status, {bool showError = true, bool silent = false}) {
    if (!showError || silent) return;

    switch (status) {
      case 401:
        if (!isGuestSession()) {
          _showSmartError('auth_401', '🔐 الجلسة منتهية'.tr, description: 'سجل دخول مرة أخرى'.tr);
          Get.offAll(() => LoginScreen(), transition: Transition.fadeIn);
        }

        break;

      case 403:
        _showSmartError('forbidden_403', '⛔ ليس لديك صلاحية'.tr);
        break;

      case 404:
        if (!silent) {
          _showSmartError('not_found_404', '🔍 غير موجود'.tr);
        }
        break;

      case 422:
        break;

      case 429:
        _showSmartError(
          'rate_limit_429',
          '⏱️ انتظر قليلاً'.tr,
          duration: const Duration(seconds: 4),
        );
        break;

      case 500:
      case 502:
      case 503:
        _showSmartError(
          'server_error_5xx',
          '⚠️ مشكلة مؤقتة'.tr,
          description: 'جاري إعادة المحاولة...'.tr,
        );
        break;
    }
  }

  static void resetErrorCounters() {
    _errorCounter.clear();
    _lastErrorShown.clear();
    _consecutiveFailures = 0;
    _isOfflineMode = false;
  }

  static bool get isOffline => _isOfflineMode;
}

class SmartNetworkInterceptor extends Interceptor {
  static DateTime? _lastConnectionError;
  static int _connectionErrorCount = 0;
  static const Duration _connectionErrorCooldown = Duration(seconds: 15);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final showErrors = err.requestOptions.extra['showErrors'] ?? true;
    final silent = err.requestOptions.extra['silent'] ?? false;

    if (!showErrors || silent) {
      return handler.next(err);
    }

    final now = DateTime.now();

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      _connectionErrorCount++;

      if (_lastConnectionError == null ||
          now.difference(_lastConnectionError!) > _connectionErrorCooldown) {
        _lastConnectionError = now;

        if (_connectionErrorCount <= 2) {
          CustomSnackbar.warning('⏱️ الاتصال بطيء'.tr);
        }
      }
    } else if (err.error is SocketException) {
      if (_lastConnectionError == null ||
          now.difference(_lastConnectionError!) > _connectionErrorCooldown) {
        _lastConnectionError = now;
        CustomSnackbar.error('📡 لا يوجد إنترنت'.tr);
      }
    } else if (err.response != null) {
      DioHelper.handleStatusCode(
        err.response!.statusCode ?? 0,
        showError: showErrors,
        silent: silent,
      );
    }

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final showErrors = response.requestOptions.extra['showErrors'] ?? true;
    final silent = response.requestOptions.extra['silent'] ?? false;
    if (response.statusCode != null && response.statusCode! < 400) {
      _connectionErrorCount = 0;
    }

    DioHelper.handleStatusCode(response.statusCode ?? 0, showError: showErrors, silent: silent);
    handler.next(response);
  }
}

class RetryInterceptor extends Interceptor {
  final Dio dio;

  RetryInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final enableRetry = err.requestOptions.extra['enableRetry'] ?? false;
    if (!enableRetry) {
      return handler.next(err);
    }

    final shouldRetry =
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.unknown ||
        (err.response?.statusCode ?? 0) >= 500;

    if (shouldRetry) {
      final retryCount = err.requestOptions.extra['retryCount'] ?? 0;

      if (retryCount < DioHelper._maxRetries) {
        await Future.delayed(DioHelper._retryDelay * (retryCount + 1));

        final options = err.requestOptions;
        options.extra['retryCount'] = retryCount + 1;

        try {
          final response = await dio.fetch(options);
          return handler.resolve(response);
        } catch (e) {
          printLog(e.toString());
        }
      }
    }

    handler.next(err);
  }
}
