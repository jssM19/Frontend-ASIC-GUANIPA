import 'login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String version = dotenv.env['VERSION'] ?? '1.0.0';

    return MaterialApp(
      title: "Login App - $version",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // Tu pantalla de login
      debugShowCheckedModeBanner: false,
    );
  }
}
