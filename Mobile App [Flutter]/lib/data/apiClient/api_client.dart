import 'dart:async';
import 'dart:convert';

// import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/core/utils/progress_dialog_utils.dart';
import 'package:fotisia/data/models/loginAuth/post_login_auth_resp.dart';
import 'package:fotisia/data/models/me/get_me_resp.dart';
import 'package:fotisia/data/models/registerDeviceAuth/post_register_device_auth_resp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network_interceptor.dart';
import 'dart:io';

class _MyHttpOverrides extends HttpOverrides {}

class ApiClient {
  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();

  var url = dotenv.env['FOTISIA_BACKEND_BASE_URL'];
  static final ApiClient _apiClient = ApiClient._internal();


  final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 6000) ,
  ))
  ..httpClientAdapter =  IOHttpClientAdapter()
  ..interceptors.add(CachingInterceptor());


  ///method can be used for checking internet connection
  ///returns [bool] based on availability of internet
  Future isNetworkConnected() async {
    if (!await NetworkInfo().isConnected()) {
      throw NoInternetException('No Internet Found!');
    }
  }

  /// is `true` when the response status code is between 200 and 299
  ///
  /// user can modify this method with custom logics based on their API response
  bool _isSuccessCall(Response response) {
    if (response.statusCode != null) {
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    }
    return false;
  }

  /// Performs API call for https://nodedemo.dhiwise.co/device/api/v1/user/me
  ///
  /// Sends a GET request to the server's 'https://nodedemo.dhiwise.co/device/api/v1/user/me' endpoint
  /// with the provided headers and request data
  /// Returns a [GetMeResp] object representing the response.
  /// Throws an error if the request fails or an exception occurs.
  FutureOr<void>  fetchMe() async {
    const storage = FlutterSecureStorage();
    HttpOverrides.global = _MyHttpOverrides();
    String? userDataJsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(userDataJsonString.toString());

    await getData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}",
      },
      path: "api/user/current/profile/${userData['id']}",
      useCache: false,
    ).then((value) async {
      PostLoginAuthResp.saveToSecureStorage(value);

    }).onError((error, stackTrace) {
      print(error);
      Fluttertoast.showToast(msg: "Error fetching updated data", toastLength: Toast.LENGTH_LONG);
    });
  }


  Future<Map<String, dynamic>> getResume() async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/resume/user/${userData['id']}";

    try{
      Map<String, dynamic> value = await _apiClient.getData(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${userData['accessToken']}"
          },
          path: path,
          showLoading: false,
      );

      return value;
    } on DioException catch (e) {
      ProgressDialogUtils.hideProgressDialog();

      if (e.response != null) {
        // print(e.response?.data); // this prints the custom error message from the backend.
        // print(e.response?.statusMessage); // This prints the status code meaning (NOT_FOUND or CONFLICT)

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

      }
      else
      {
        // Something happened in setting up or sending the request that triggered an Error
        print("The error: ${e.message}");
      }
      rethrow;
    }
  }

  /// Performs a post API call
  Future<dynamic> postData({
    Map<String, String> headers = const {},
    Map requestData = const {},
    FormData? formData,
    showProgress = true,
    String path = ""
  }) async {
    if(showProgress) ProgressDialogUtils.showProgressDialog();
    HttpOverrides.global = _MyHttpOverrides();

    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/$path',
        data: formData ?? requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return response.data;
      } else {
        throw response.data["message"] ?? 'Something Went Wrong!';
      }
    } on DioException catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      if (e.response != null) {
        // print(e.response?.data); // this prints the custom error message from the backend.
        // print(e.response?.statusMessage); // This prints the status code meaning (NOT_FOUND or CONFLICT)

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

      }
      else
      {
        // Something happened in setting up or sending the request that triggered an Error
        print("The error: ${e.message}");
      }
      rethrow;
    }
  }


  /// Performs a put API call
  Future<dynamic> putData({
    Map<String, String> headers = const {},
    Map requestData = const {},
    FormData? formData,
    showProgress = true,
    String path = ""
  }) async {
    if(showProgress) ProgressDialogUtils.showProgressDialog();
    HttpOverrides.global = _MyHttpOverrides();

    try {
      await isNetworkConnected();
      var response = await _dio.put(
        '$url/$path',
        data: formData ?? requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return response.data;
      } else {
        throw response.data["message"] ?? 'Something Went Wrong!';
      }
    } on DioException catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      if (e.response != null) {
        // print(e.response?.data); // this prints the custom error message from the backend.
        // print(e.response?.statusMessage); // This prints the status code meaning (NOT_FOUND or CONFLICT)

        if(e.response?.statusCode == 401)
        {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();

          var storage = const FlutterSecureStorage();
          storage.deleteAll();

          NavigatorService.pushNamed(
            AppRoutes.loginScreen,
          );
        }

      }
      else
      {
        // Something happened in setting up or sending the request that triggered an Error
        print("The error: ${e.message}");
      }
      rethrow;
    }
  }

  Future <void> getUpdate (Function callBack, String path, emit, event) async {
    try {
        print("Stream listened to.");
        await for (final value in _apiClient.cacheInterceptor().onUpdate) {
          if (value.key.contains(path)) {
            await Future.delayed(const Duration(seconds: 7));
            await _apiClient.cacheInterceptor().nullifyCacheEntry(value.key);
            await callBack(event, emit, getUpdated: false);
            return;
          }
        }

    } catch (e) { print(e); }
  }

  /// Performs a get API call
  CachingInterceptor cacheInterceptor() {
    // Somewhere in your UI code
    final cachingInterceptor = (_dio.interceptors[1]);
    return cachingInterceptor as CachingInterceptor;
  }

  /// Performs a get API call
  Future<dynamic> getData({
    Map<String, String> headers = const {},
    String path = "",
    showLoading = false,
    useCache = true
  }) async {

    if(showLoading) ProgressDialogUtils.showProgressDialog();
    HttpOverrides.global = _MyHttpOverrides();

    try {
      await isNetworkConnected();
      headers.addAll({"useCache": useCache.toString()});

      var response = await _dio.get(
        '$url/$path',
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return response.data;
      } else {
        throw response.data["message"] ?? 'Something Went Wrong!';
      }
    }  on DioException catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // print(e.response?.data); // this prints the custom error message from the backend.
        // print(e.response?.statusMessage); // This prints the status code meaning (NOT_FOUND or CONFLICT)

        if(e.response?.statusCode == 401)
        {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();

          var storage = const FlutterSecureStorage();
          storage.deleteAll();

          NavigatorService.pushNamed(
            AppRoutes.loginScreen,
          );
        }
      }
      else
      {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
      }
      rethrow;
    }
  }

  /// Performs a post API call
  Future<dynamic> deleteData({
    Map<String, String> headers = const {},
    showProgress = true,
    String path = ""
  }) async {
    if(showProgress) ProgressDialogUtils.showProgressDialog();
    HttpOverrides.global = _MyHttpOverrides();

    try {
      await isNetworkConnected();
      var response = await _dio.delete(
        '$url/$path',
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return response.data;
      } else {
        throw response.data["message"] ?? 'Something Went Wrong!';
      }
    } on DioError catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      if (e.response != null) {
        if(e.response?.statusCode == 401)
        {
          var storage = const FlutterSecureStorage();
          storage.deleteAll();
          NavigatorService.pushNamed(
            AppRoutes.loginScreen,
          );
        }
      }
      else
      {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
      }
      rethrow;
    }
  }

  /// Performs a post API call
  Future<dynamic> patchData({
    Map<String, String> headers = const {},
    Map requestData = const {},
    FormData? formData,
    showProgress = true,
    String path = ""
  }) async {
    if(showProgress) ProgressDialogUtils.showProgressDialog();
    HttpOverrides.global = _MyHttpOverrides();

    try {
      await isNetworkConnected();
      var response = await _dio.patch(
        '$url/$path',
        data: formData ?? requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return response.data;
      } else {
        throw response.data["message"] ?? 'Something Went Wrong!';
      }
    } on DioError catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      if (e.response != null) {
        if(e.response?.statusCode == 401)
        {
          var storage = const FlutterSecureStorage();
          storage.deleteAll();
          NavigatorService.pushNamed(
            AppRoutes.loginScreen,
          );
        }
      }
      else
      {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
      }
      rethrow;
    }
  }

  /// Performs API call for https://nodedemo.dhiwise.co/device/auth/register
  ///
  /// Sends a POST request to the server's 'https://nodedemo.dhiwise.co/device/auth/register' endpoint
  /// with the provided headers and request data
  /// Returns a [PostRegisterDeviceAuthResp] object representing the response.
  /// Throws an error if the request fails or an exception occurs.
  Future<PostRegisterDeviceAuthResp> registerDeviceAuth({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    HttpOverrides.global = _MyHttpOverrides();

    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/auth/register',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        PostRegisterDeviceAuthResp.saveToSecureStorage(response.data);
        return PostRegisterDeviceAuthResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostRegisterDeviceAuthResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    }  on DioError catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw PostRegisterDeviceAuthResp.fromJson(e.response?.data);
      }
      else
      {
        // Something happened in setting up or sending the request that triggered an Error
        Map <String, dynamic> errorRes = {"message": e.message, "status": "failed"};
        throw PostRegisterDeviceAuthResp.fromJson(errorRes);
      }
      rethrow;
    }
  }

  /// Performs API call for https://nodedemo.dhiwise.co/device/auth/register
  ///
  /// Sends a POST request to the server's 'https://nodedemo.dhiwise.co/device/auth/register' endpoint
  /// with the provided headers and request data
  /// Returns a [PostRegisterDeviceAuthResp] object representing the response.
  /// Throws an error if the request fails or an exception occurs.
  Future<PostLoginAuthResp> loginDeviceAuth({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    HttpOverrides.global = _MyHttpOverrides();

    try {
      await isNetworkConnected();

      var response = await _dio.post(
        '$url/api/auth/login',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        PostLoginAuthResp.saveToSecureStorage(response.data);
        return PostLoginAuthResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostLoginAuthResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    }  on DioError catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print("The error: ${e.response?.data}");
        // throw PostLoginAuthResp.fromJson(e.response?.data);
      }
      else
      {
        // Something happened in setting up or sending the request that triggered an Error
        Map <String, dynamic> errorRes = {"message": e.message, "status": "failed"};
        print("The error: $e");
        print("The error: ${e.message}");
        throw PostLoginAuthResp.fromJson(errorRes);
      }
      rethrow;
    }
  }
}
