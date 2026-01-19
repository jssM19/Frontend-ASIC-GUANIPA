import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:asis_guanipa_frontend/router_app.dart';
import 'package:asis_guanipa_frontend/providers/auth_providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
          create: (context) => GoRouteInformationProvider(
            initialLocation: "/",
            initialExtra: "/",
          ),
        ),
      ],

      child: MaterialApp.router(
        routerConfig: router,
        title: "Asic Guanipa",
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
      ),

      // home:   // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
