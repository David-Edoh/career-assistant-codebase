// ignore_for_file: unnecessary_overrides
// https://stackoverflow.com/questions/76127993/is-it-possible-to-use-dio-package-but-shared-preferences-package-for-caching

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/navigator_service.dart';
import '../../core/utils/progress_dialog_utils.dart';
import '../../routes/app_routes.dart';

/// NetworkInterceptor class for intercepting API requests, responses, and exceptions.
///
/// This class extends the [Interceptor] class from the Dio HTTP client library
/// and overrides the [onRequest], [onError] and [onResponse] methods to intercept
/// different stages of the API request lifecycle.
///
/// use this class to add custom logic or perform actions such as logging,
/// modifying headers, or handling errors before and after making API requests.
class CachingInterceptor extends Interceptor {
  CachingInterceptor({
    this.cacheDuration = const Duration(seconds: 5),
  });


  // Create a StreamController to handle the update notifications
  StreamController<NetworkCacheEntry> updateStreamController = StreamController<NetworkCacheEntry>.broadcast();

  // Expose the stream for external listeners
  Stream<NetworkCacheEntry> get onUpdate => updateStreamController.stream.asBroadcastStream();

  final Duration cacheDuration;

  final cacheService = SharedPrefsNetworkCacheService();

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final cacheKey = options.uri.toString();
    final cachedEntry = await cacheService.getEntry(cacheKey);

    if (cachedEntry != null && options.method == "GET" && options.headers["useCache"] == "true") {
      bool expired = await cacheService.hasCacheExpired(cacheKey) as bool;
      // NetworkCacheEntry entry = await cacheService.getEntry(cacheKey) as NetworkCacheEntry;

      if(expired)
      {
        final response = _buildResponse(cachedEntry, options);

        handler.resolve(response);

        // Make a request to check if the data has changed
        _checkForUpdate(options, cachedEntry, handler);
      }
      else
      {
        final response = _buildResponse(cachedEntry, options);

        handler.resolve(response);
      }
    }
    else
    {
      return handler.next(options);
    }
  }

  Future<void> nullifyCacheEntry(String key) async {
    await cacheService._sharedPrefs.remove(key);
  }

  Future<void> _checkForUpdate(
      RequestOptions options,
      NetworkCacheEntry cachedEntry,
      RequestInterceptorHandler handler,
      ) async {
    try {
      // Make a request to check for updates
      final response = await Dio().get(
        options.uri.toString(),
        options: Options(
          method: options.method,
          headers: options.headers,
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // If the data has changed, update the cache
        final updatedEntry =
        NetworkCacheEntry.fromResponse(response, cacheDuration);
        await cacheService._sharedPrefs.remove(updatedEntry.key);
        await cacheService.putEntry(updatedEntry);

        // Notify listeners about the update
        updateStreamController.add(updatedEntry);

        // Uncomment the next line if you want to resolve the original request
        // return handler.resolve(response);
      }
    } on DioException catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      if(e.response?.statusCode == 401)
      {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();

        var storage = const FlutterSecureStorage();
        await storage.deleteAll();

        NavigatorService.pushNamed(
          AppRoutes.loginScreen,
        );
      }
      // Handle DioError as needed
      // ...
      rethrow;
    }
  }

  void cancelStream() async {
    updateStreamController.close();
  }

  void addListenerToUpdateCacheUpdateStream(Function callBack) async {
    updateStreamController.stream.listen((event) {
      callBack(event);
    });
  }

  // Dispose of the stream controller when it's no longer needed
  @override
  void dispose() {
    updateStreamController.close();
    // super.dispose();
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final statusCode = response.statusCode;

    // Only cache successful get responses
    if (statusCode != null && statusCode >= 200 && statusCode < 300  && response.requestOptions.method == "GET") {
      final entry = NetworkCacheEntry.fromResponse(
        response,
        cacheDuration,
      );
      await cacheService.putEntry(entry);
    }

    return handler.next(response);
  }

  Response _buildResponse(
      NetworkCacheEntry cachedEntry,
      RequestOptions options,
      ) {
    return Response(
      requestOptions: options,
      statusCode: cachedEntry.statusCode,
      data: cachedEntry.value,
    );
  }
}

class SharedPrefsNetworkCacheService {
  bool _initialized = false;
  bool get initialized => _initialized;

  late final SharedPreferences _sharedPrefs;

  Future<void> _init() async {
    if (_initialized) return;

    _sharedPrefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  Future<bool?> hasCacheExpired(String key) async
  {
    if (!_initialized) await _init();

    final cachedEntry = _sharedPrefs.getString(key);

    final entry = NetworkCacheEntry.fromJson(
      jsonDecode(cachedEntry!) as Map<String, dynamic>,
    );

    if (!entry.isValid) {
      return true;
    }
    return false;
  }

  Future<NetworkCacheEntry?> getEntry(String key) async {
    if (!_initialized) await _init();

    final cachedEntry = _sharedPrefs.getString(key);
    if (cachedEntry == null) return null;

    final entry = NetworkCacheEntry.fromJson(
      jsonDecode(cachedEntry) as Map<String, dynamic>,
    );

    // Remove expired entries
    // if (!entry.isValid) {
    //   await _sharedPrefs.remove(entry.key);
    //   return null;
    // }

    return entry;
  }

  Future<bool> putEntry(NetworkCacheEntry entry) async {
    if (!_initialized) await _init();

    final json = jsonEncode(entry.toJson());
    return _sharedPrefs.setString(entry.key, json);
  }
}

class NetworkCacheEntry {
  const NetworkCacheEntry({
    required this.key,
    required this.statusCode,
    required this.value,
    required this.expiry,
  });

  factory NetworkCacheEntry.fromResponse(
      Response response,
      Duration cacheDuration,
      ) {
    return NetworkCacheEntry(
      key: response.requestOptions.uri.toString(),
      statusCode: response.statusCode,
      value: response.data,
      expiry: DateTime.now().add(cacheDuration),
    );
  }

  factory NetworkCacheEntry.fromJson(Map<String, dynamic> json) {
    return NetworkCacheEntry(
      key: json['key'] as String,
      statusCode: json['statusCode'] as int?,
      value: json['value'],
      expiry: DateTime.parse(json['expiry'] as String),
    );
  }

  final String key;
  final int? statusCode;
  final dynamic value;
  final DateTime expiry;

  bool get isValid => expiry.isAfter(DateTime.now());

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'statusCode': statusCode,
      'value': value,
      'expiry': expiry.toIso8601String(),
    };
  }
}
