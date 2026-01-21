import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:asis_guanipa_frontend/providers/auth_providers.dart';

class MinimalLoadingScreen extends StatefulWidget {
  const MinimalLoadingScreen({super.key});
  @override
  State<MinimalLoadingScreen> createState() => _MinimalLoadingScreenState();
}

class _MinimalLoadingScreenState extends State<MinimalLoadingScreen> {
  @override
  void initState() {
    super.initState();

    // Esperar a que el widget esté completamente construido
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthentication();
    });
  }

  void _checkAuthentication() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadData();

    if (!mounted) {
      return;
    }

    if (authProvider.hasSession()) {
      GoRouter.of(context).push("/");
      return;
    }

    GoRouter.of(context).push("/signin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spinner con logo
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      strokeWidth: 2,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Texto con tipografía bonita
              Text(
                'Asis Guanipa',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Iniciando sesión automática',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
