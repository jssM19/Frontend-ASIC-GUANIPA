import 'package:flutter/material.dart';
import 'screen/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String version = String.fromEnvironment(
      "VERSION",
      defaultValue: "0.0.1-alpha",
    );

    return MaterialApp(
      title: "Login App - $version",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // Tu pantalla de login
      debugShowCheckedModeBanner: false,
    );
  }
}
