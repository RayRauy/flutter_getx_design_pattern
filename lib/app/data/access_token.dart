import 'package:get_storage/get_storage.dart';

class AccessToken {
  static final _storage = GetStorage();
  static final String _accessToken = "ACCESS_TOKEN";
  static final String _refreshToken = "REFRESH_TOKEN";
  static final String _username = "USERNAME";

  static void saveToken({String? token, String? refresh, String? username}){
    _storage.write(_accessToken, token);
    _storage.write(_refreshToken, refresh);
    _storage.write(_username, username);
  }

  static void removeToken(){
    _storage.remove(_accessToken);
    _storage.remove(_refreshToken);
    _storage.remove(_username);
  }

  static String getToken() => _storage.read(_accessToken)??"";
  static  String getRefreshToken() => _storage.read(_refreshToken)??"";
  static String getUsername() => _storage.read(_username)??"";
}