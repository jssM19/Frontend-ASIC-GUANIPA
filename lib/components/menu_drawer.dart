import 'package:flutter/material.dart';

class menuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header del drawer
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'john.doe@email.com',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // Opciones del menú
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a home
            },
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a perfil
            },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a configuración
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.help),
            title: Text('Ayuda'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a ayuda
            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () {
              Navigator.pop(context);
              // Lógica para cerrar sesión
            },
          ),
        ],
      ),
    );
  }
}
