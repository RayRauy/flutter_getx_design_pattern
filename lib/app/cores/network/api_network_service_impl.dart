import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/cores/constants/constant_uri.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/auth/refresh_token_request.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/auth/login_request.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/auth/login_response.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/auth/register_request.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/auth/register_response.dart';
import 'package:flutter_getx_design_pattern/app/cores/network/api_network_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_getx_design_pattern/app/data/access_token.dart';

class ApiNetworkServiceImpl extends ApiNetworkService {
  Map<String, String> get _headers => {
        "Content-Type": "application/json",
      };

  Map<String, String> get _authHeaders => {
        ..._headers,
        "Authorization": "Bearer ${AccessToken.getToken()}",
      };

  @override
  Future<LoginResponse> login(LoginRequest req) async {
    LoginResponse loginResponse = LoginResponse();
    var url = Uri.parse(ConstantUri.loginPath);
    var response = await http.post(
      url,
      body: jsonEncode(req.toJson()),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
    }
    return loginResponse;
  }

  @override
  Future<RegisterResponse> register(RegisterRequest req) async {
    RegisterResponse registerResponse = RegisterResponse();
    var url = Uri.parse(ConstantUri.registerPath);
    var response = await http.post(
      url,
      body: jsonEncode(req.toJson()),
      headers: _headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      registerResponse = RegisterResponse.fromJson(jsonDecode(response.body));
    }
    return registerResponse;
  }

  @override
  Future<bool> refreshToken() async {
    var url = Uri.parse(ConstantUri.refreshPath);
    var refreshToken = AccessToken.getRefreshToken();
    print("DEBUG: Refreshing token with: $refreshToken");
    
    var response = await http.post(
      url,
      body: jsonEncode(
        RefreshTokenRequest(refreshToken: refreshToken).toJson(),
      ),
      headers: _headers,
    );

    print("DEBUG: Refresh Status Code: ${response.statusCode}");
    print("DEBUG: Refresh Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      AccessToken.saveToken(
        token: loginResponse.accessToken,
        refresh: loginResponse.refreshToken,
        username: loginResponse.user?.username,
      );
      print("DEBUG: Token refreshed. New Access Token: ${loginResponse.accessToken}");
      return true;
    } else {
      print("DEBUG: Refresh failed. Redirecting to login.");
      AccessToken.removeToken();
      Get.offAllNamed("/login");
      return false;
    }
  }

  @override
  Future get(String uri) async {
    var url = Uri.parse(uri);
    var token = AccessToken.getToken();
    print("DEBUG: GET $uri");
    print("DEBUG: Current Token: $token");
    
    var response = await http.get(url, headers: _authHeaders);
    print("DEBUG: Initial GET Status: ${response.statusCode}");

    if (response.statusCode == 200) {
      return response.body;
    }

    if (response.statusCode == 401) {
      print("DEBUG: 401 Unauthorized detected. Attempting refresh...");
      if (await refreshToken()) {
        var newToken = AccessToken.getToken();
        print("DEBUG: Retrying GET $uri with new token: $newToken");
        var retryResponse = await http.get(url, headers: _authHeaders);
        print("DEBUG: Retry GET Status: ${retryResponse.statusCode}");
        if (retryResponse.statusCode == 200) {
          return retryResponse.body;
        }
      }
    }
    return null;
  }
}
