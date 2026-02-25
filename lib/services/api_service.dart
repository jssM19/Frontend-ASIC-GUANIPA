import 'dart:convert';
import 'package:asis_guanipa_frontend/storage/jwt_token.dart';
import 'package:http/http.dart' as http;
import '../response/login_response.dart';
import '../response/profile_response.dart';
import '../models/paciente.dart';

class ApiService {
  static const String baseUrl =
      'https://api.asic-guanipa.online/api'; // Cambia por tu URL
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Obtnener el token de JWT
  Future<ProfileResponse> currentProfile(String? token) async {
    token = token ?? await getToken();
    http.Response response;

    try {
      response = await http.get(
        Uri.parse('$baseUrl/auth/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      return ProfileResponse.fromJson({
        'success': false,
        'message': 'Error de conexión, intente nuevamente',
        'data': null,
      });
    }

    if (response.statusCode == 401) {
      return ProfileResponse.fromJson({
        'success': false,
        'message': 'Token inválido o expirado',
      });
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    return ProfileResponse.fromJson(responseData);
  }

  // Enviar enlace de recuperación de contraseña
  Future<Map<String, dynamic>> sendPasswordResetLink(String email) async {
    http.Response response;

    try {
      response = await http.post(
        Uri.parse('$baseUrl/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión, intente nuevamente',
      };
    }

    if (response.statusCode != 200) {
      return {
        'success': false,
        'message':
            'Error al enviar el enlace de recuperación, si el problema persiste contacte al administrador',
      };
    }

    return {'success': true, 'message': 'Enlace enviado correctamente'};
  }

  // Restablecer contraseña con token
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'token': token,
          'password': password,
          'password_confirmation': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': 'Contraseña actualizada correctamente',
          'token': data['token'], // Si tu API devuelve un token
        };
      } else {
        return {
          'success': false,
          'message':
              json.decode(response.body)['message'] ??
              'Error al restablecer contraseña',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error de conexión: $e'};
    }
  }

  // Verificar token de recuperación
  Future<Map<String, dynamic>> verifyResetToken(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/verify-reset-token/$token'),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'valid': true};
      } else {
        return {
          'success': false,
          'valid': false,
          'message': 'Token inválido o expirado',
        };
      }
    } catch (e) {
      return {'success': false, 'valid': false, 'message': 'Error de conexión'};
    }
  }

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

  Future<PacienteResponse> getPacientes({
    int page = 1,
    String? cedula,
    String? fecha,
    String? search,
  }) async {
    final token = await getToken();
    if (token == null) {
      return PacienteResponse.fromJson({'success': false, 'data': []});
    }

    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'limit': '6',
      };
      if (cedula != null && cedula.isNotEmpty) {
        queryParams['cedula'] = cedula;
      }
      if (fecha != null && fecha.isNotEmpty) {
        queryParams['fecha'] = fecha;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final uri = Uri.parse(
        '$baseUrl/pacientes/listado',
      ).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 401) {
        return PacienteResponse.fromJson({'success': false, 'data': []});
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      return PacienteResponse.fromJson(responseData);
    } catch (e) {
      return PacienteResponse.fromJson({'success': false, 'data': []});
    }
  }
}
