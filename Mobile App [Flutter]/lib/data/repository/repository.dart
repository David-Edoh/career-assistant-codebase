import 'package:fotisia/data/models/me/get_me_resp.dart';
import 'package:fotisia/data/models/registerDeviceAuth/post_register_device_auth_resp.dart';
import 'package:fotisia/data/models/loginAuth/post_login_auth_resp.dart';

import '../apiClient/api_client.dart';

/// Repository class for managing API requests.
///
/// This class provides a simplified interface for making the
/// API request using the [ApiClient] instance
class Repository {
  final _apiClient = ApiClient();

  Future<PostRegisterDeviceAuthResp> registerDeviceAuth({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.registerDeviceAuth(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<PostLoginAuthResp> loginDeviceAuth({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.loginDeviceAuth(
      headers: headers,
      requestData: requestData,
    );
  }
}
