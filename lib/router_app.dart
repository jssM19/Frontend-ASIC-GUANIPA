import "dart:core";
import 'package:asis_guanipa_frontend/screen/login_page.dart';
import 'package:asis_guanipa_frontend/screen/reset_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:asis_guanipa_frontend/screen/home_screen.dart';
import 'package:asis_guanipa_frontend/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import "package:asis_guanipa_frontend/screen/loading_screen.dart";

final Set<String> routesWithoutSignin = <String>{"/signin", "/reset-password"};

String normalizeIncomingUri(Uri u) {
  if (!u.hasScheme) {
    return u.toString();
  }
  final isHttp = u.scheme == 'http' || u.scheme == 'https';
  if (isHttp) {
    final path = u.path.isEmpty ? '/' : u.path;
    return Uri(
      path: path,
      queryParameters: u.queryParameters.isEmpty ? null : u.queryParameters,
    ).toString();
  }
  final segments = <String>[];
  if (u.host.isNotEmpty) {
    segments.add(u.host);
  }
  segments.addAll(u.pathSegments.where((s) => s.isNotEmpty));
  final path = '/${segments.join('/')}';
  return Uri(
    path: path,
    queryParameters: u.queryParameters.isEmpty ? null : u.queryParameters,
  ).toString();
}

// OPCIÓN ALTERNATIVA: Usar un refresh listener para recargar el router
final router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
    GoRoute(path: "/signin", builder: (context, state) => const LoginPage()),
    GoRoute(
      path: "/reset-password",
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    // Agregar ruta de carga temporal
    GoRoute(
      path: "/loading",
      builder: (context, state) => const MinimalLoadingScreen(),
    ),
  ],
  redirect: (context, state) {
    final String path = normalizeIncomingUri(state.uri);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Si aún está cargando, ir a pantalla de carga (excepto para rutas sin sesión)
    if (authProvider.isLoading() && path != "/reset-password") {
      return '/loading';
    }

    if (!authProvider.isLoading() &&
        authProvider.hasSession() &&
        path == "/loading") {
      return "/";
    }

    if (authProvider.hasSession() && routesWithoutSignin.contains(path)) {
      return "/";
    }

    if (!authProvider.hasSession() && !routesWithoutSignin.contains(path)) {
      return '/signin';
    }

    return null;
  },
);
