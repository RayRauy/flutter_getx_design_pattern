import 'user.dart';

class RegisterResponse {
  RegisterResponse({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.user,
    this.message,
    this.code,
    this.data,
  });

  RegisterResponse.fromJson(dynamic json) {
    message = json['message'];
    code = json['code'];
    data = json['data'];

    // If the data is an object, try to map tokens (standard flow)
    if (data is Map) {
      accessToken = data['accessToken'] ?? data['access_token'] ?? data['token'];
      tokenType = data['tokenType'] ?? data['token_type'];
      refreshToken = data['refreshToken'] ?? data['refresh_token'];
      expiresIn = data['expiresIn'] ?? data['expires_in'];
      user = data['user'] != null ? User.fromJson(data['user']) : null;
    } 
    // If tokens are at the root
    else {
      accessToken = json['accessToken'] ?? json['access_token'] ?? json['token'];
      tokenType = json['tokenType'] ?? json['token_type'];
      refreshToken = json['refreshToken'] ?? json['refresh_token'];
      expiresIn = json['expiresIn'] ?? json['expires_in'];
      user = json['user'] != null ? User.fromJson(json['user']) : null;
    }
  }

  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  User? user;
  String? message;
  String? code;
  dynamic data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['tokenType'] = tokenType;
    map['refreshToken'] = refreshToken;
    map['expiresIn'] = expiresIn;
    map['message'] = message;
    map['code'] = code;
    map['data'] = data;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
