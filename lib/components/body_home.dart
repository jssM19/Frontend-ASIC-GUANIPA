import 'package:flutter/material.dart';
import '../screen/menu_item.dart';

class BodyHome extends StatelessWidget {
  BodyHome({super.key});

  final menuItems = <MenuItem>[
    MenuItem(
      title: 'Jornada Diaria',
      iconPath: 'assets/icons/daily.png', // Necesitarás crear estos iconos
      route: '/jornada-diaria',
    ),
    MenuItem(
      title: 'Registro Nominal',
      iconPath: 'assets/icons/register.png',
      route: '/registro-nominal',
    ),
    MenuItem(
      title: 'Almacén',
      iconPath: 'assets/icons/warehouse.png',
      route: '/almacen',
    ),
    MenuItem(
      title: 'Reportes',
      iconPath: 'assets/icons/reports.png',
      route: '/reportes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con información del centro
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D47A1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.medical_services,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Inventario',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Text(
                            'Centro de Salud Pedro Urbina',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Sistema de Gestión de Inventarios',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Título de módulos
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Módulos del Sistema',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Grid de módulos
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return _buildMenuItemCard(context, menuItems[index]);
                },
              ),
            ),

            // Pie de página
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Versión 1.0',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    'Usuario: Admin',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuItemCard(BuildContext context, MenuItem item) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // Navegar a la ruta correspondiente
        // Navigator.pushNamed(context, item.route);
        _showComingSoon(context, item.title);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono del módulo
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _getColorForModule(item.title),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(child: _getIconForModule(item.title)),
            ),

            const SizedBox(height: 16),

            // Título del módulo
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),

            const SizedBox(height: 8),

            // Descripción breve
            /*    Text(
              _getDescriptionForModule(item.title),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),*/
          ],
        ),
      ),
    ),
  );
}

Widget _getIconForModule(String title) {
  switch (title) {
    case 'Jornada Diaria':
      return const Icon(Icons.calendar_today, color: Colors.white, size: 32);
    case 'Registro Nominal':
      return const Icon(Icons.assignment, color: Colors.white, size: 32);
    case 'Almacén':
      return const Icon(Icons.inventory, color: Colors.white, size: 32);
    case 'Reportes':
      return const Icon(Icons.analytics, color: Colors.white, size: 32);
    default:
      return const Icon(Icons.business, color: Colors.white, size: 32);
  }
}

Color _getColorForModule(String title) {
  switch (title) {
    case 'Jornada Diaria':
      return const Color(0xFF4CAF50); // Verde
    case 'Registro Nominal':
      return const Color(0xFF2196F3); // Azul
    case 'Almacén':
      return const Color(0xFFFF9800); // Naranja
    case 'Reportes':
      return const Color(0xFF9C27B0); // Púrpura
    default:
      return const Color(0xFF0D47A1);
  }
}

/*String _getDescriptionForModule(String title) {
  switch (title) {
    case 'Jornada Diaria':
      return 'Control diario de inventario';
    case 'Registro Nominal':
      return 'Registro detallado de items';
    case 'Almacén':
      return 'Gestión de productos';
    case 'Reportes':
      return 'Generación de informes';
    default:
      return 'Módulo del sistema';
  }
} */

void _showComingSoon(BuildContext context, String module) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Próximamente'),
      content: Text('El módulo "$module" estará disponible pronto.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
