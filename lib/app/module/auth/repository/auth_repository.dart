import 'package:flutter_getx_design_pattern/app/cores/models/auth/login_response.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/auth/register_request.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/auth/register_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login({String? username, String? password});
  Future<RegisterResponse> register(RegisterRequest request);
}
