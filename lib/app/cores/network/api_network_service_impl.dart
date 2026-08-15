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
    
    var response = await http.post(
      url,
      body: jsonEncode(
        RefreshTokenRequest(refreshToken: refreshToken).toJson(),
      ),
      headers: _headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      AccessToken.saveToken(
        token: loginResponse.accessToken,
        refresh: loginResponse.refreshToken,
        username: loginResponse.user?.username,
      );
      return true;
    } else {
      AccessToken.removeToken();
      Get.offAllNamed("/login");
      return false;
    }
  }

  @override
  Future get(String uri) async {
    var url = Uri.parse(uri);
    var response = await http.get(url, headers: _authHeaders);

    if (response.statusCode == 200) {
      return response.body;
    }

    if (response.statusCode == 401) {
      if (await refreshToken()) {
        var retryResponse = await http.get(url, headers: _authHeaders);
        if (retryResponse.statusCode == 200) {
          return retryResponse.body;
        }
      }
    }
    return null;
  }

  @override
  Future post(String uri, body) async {
    var url = Uri.parse(uri);
    var response = await http.post(url, headers: _authHeaders, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }

    if (response.statusCode == 401) {
      if (await refreshToken()) {
        var retryResponse = await http.post(url, headers: _authHeaders, body: jsonEncode(body));
        if (retryResponse.statusCode == 200 || retryResponse.statusCode == 201) {
          return retryResponse.body;
        }
      }
    }
    return null;
  }

  @override
  Future put(String uri, body) async {
    var url = Uri.parse(uri);
    var response = await http.put(url, headers: _authHeaders, body: jsonEncode(body));

    if (response.statusCode == 200) {
      return response.body;
    }

    if (response.statusCode == 401) {
      if (await refreshToken()) {
        var retryResponse = await http.put(url, headers: _authHeaders, body: jsonEncode(body));
        if (retryResponse.statusCode == 200) {
          return retryResponse.body;
        }
      }
    }
    return null;
  }

  @override
  Future delete(String uri) async {
    var url = Uri.parse(uri);
    print("DEBUG: DELETE $uri");
    var response = await http.delete(url, headers: _authHeaders);

    if (response.statusCode == 200 || response.statusCode == 204) {
      return response.body;
    }

    if (response.statusCode == 401) {
      if (await refreshToken()) {
        var retryResponse = await http.delete(url, headers: _authHeaders);
        if (retryResponse.statusCode == 200 || retryResponse.statusCode == 204) {
          return retryResponse.body;
        }
      }
    }
    return null;
  }
}
