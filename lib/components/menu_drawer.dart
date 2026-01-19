import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asis_guanipa_frontend/storage/jwt_token.dart';
import "package:asis_guanipa_frontend/screen/login_page.dart";
import 'package:asis_guanipa_frontend/providers/auth_providers.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  Widget _circleProfile(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.getCurrentUser();

    if (currentUser == null) {
      return CircularProgressIndicator();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
        ),
        SizedBox(height: 10),
        Text(
          currentUser.username ?? "",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(currentUser.email ?? "", style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header del drawer
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: _circleProfile(context),
          ),

          // Opciones del menú
          ListTile(
            leading: Icon(Icons.vaccines),
            title: Text('Jornada Diaria'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a home
            },
          ),

          ListTile(
            leading: Icon(Icons.groups),
            title: Text('Registro Nominal'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a perfil
            },
          ),

          ListTile(
            leading: Icon(Icons.store),
            title: Text('Almacén'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a configuración
            },
          ),
          ListTile(
            leading: Icon(Icons.poll),
            title: Text('Reportes'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a configuración
            },
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text('Gestión de Descartes'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a configuración
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.person),
            title: Text('Usuarios'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a ayuda
            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () {
              deleteToken();
              Navigator.pop(context); // Cerrar el drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ); // Ejecutar logout inmediatamente
            },
          ),
        ],
      ),
    );
  }
}
