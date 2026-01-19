import 'package:flutter/material.dart';
import 'package:asis_guanipa_frontend/storage/jwt_token.dart' as Jwt;
import 'package:asis_guanipa_frontend/services/api_service.dart';
import 'package:asis_guanipa_frontend/response/login_response.dart';
import 'package:asis_guanipa_frontend/response/profile_response.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  ProfileData? _currentUser;

  AuthProvider() {
    loadData();
  }

  String? getToken() {
    return _token;
  }

  bool hasSession() {
    return _currentUser != null && _token != null;
  }

  ProfileData? getCurrentUser() {
    return _currentUser;
  }

  Future<void> loadData() async {
    final token = await Jwt.getToken();
    final apiService = ApiService();
    final ProfileResponse profileResponse = await apiService.currentProfile(
      token,
    );

    if (profileResponse.success == false) {
      return;
    }

    _currentUser = profileResponse.data;
    _token = token;
    notifyListeners();
  }

  Future<LoginResponse> signIn({
    required String email,
    required String password,
  }) async {
    final apiService = ApiService();
    final LoginResponse loginResponse = await apiService.login(email, password);

    if (!loginResponse.success) {
      return loginResponse;
    }

    final token = loginResponse.data!.token;
    final ProfileResponse profileResponse = await apiService.currentProfile(
      token,
    );

    if (profileResponse.success == false) {
      return LoginResponse(
        success: false,
        message:
            "No ha sido posible obtener el perfil del usuario. contacte al administrador.",
        data: null,
      );
    }

    Jwt.saveToken(token);
    _token = token;
    _currentUser = profileResponse.data;
    notifyListeners();
    return loginResponse;
  }

  Future<void> signOut() async {
    _token = null;
    _currentUser = null;
    notifyListeners();
  }
}
