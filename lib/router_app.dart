import "dart:core";
import 'package:asis_guanipa_frontend/screen/login_page.dart';
import 'package:asis_guanipa_frontend/screen/reset_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:asis_guanipa_frontend/screen/home_screen.dart';
import 'package:asis_guanipa_frontend/providers/auth_providers.dart';
import "package:asis_guanipa_frontend/screen/loading_screen.dart";
import "package:asis_guanipa_frontend/screen/nominal_register/list_patients.dart";

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
    GoRoute(
      path: "/",
      builder: (context, state) =>
          MinimalLoadingScreen(child: const HomeScreen()),
    ),
    GoRoute(
      path: "/list-patients",
      builder: (context, state) => const ListPatients(),
    ),
    GoRoute(
      path: "/signin",
      builder: (context, state) =>
          MinimalLoadingScreen(hasSession: false, child: const LoginPage()),
    ),
    GoRoute(
      path: "/reset-password",
      builder: (context, state) => MinimalLoadingScreen(
        hasSession: false,
        child: const ResetPasswordScreen(),
      ),
    ),
  ],
  redirect: (context, state) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String path = state.uri.toString();

    if (!authProvider.hasSession() && !routesWithoutSignin.contains(path)) {
      return '/signin';
    }

    if (authProvider.hasSession() && routesWithoutSignin.contains(path)) {
      return "/";
    }

    return null;
  },
);
