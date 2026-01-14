import 'dart:convert';
import 'package:http/http.dart' as http;
import '../response/login_response.dart';

class ApiService {
  static const String baseUrl =
      'https://api.asic-guanipa.online/api'; // Cambia por tu URL
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<LoginResponse> login(String email, String password) async {
    http.Response? response = null;
    try {
      final url = Uri.parse(
        '$baseUrl/auth/login',
      ); // Cambia la ruta según tu API
      response = await http.post(
        url,
        headers: headers,
        body: json.encode({'email': email, 'password': password}),
      );
    } catch (e) {
      return LoginResponse.fromJson({
        'success': false,
        'message': 'Error de conexión',
        'data': null,
      });
    }

    print(response);

    if (response.statusCode == 401) {
      return LoginResponse.fromJson({
        'success': false,
        'message': 'Usuario o contraseña incorrecta',
        'data': null,
      });
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    return LoginResponse.fromJson(responseData);
  }
}
