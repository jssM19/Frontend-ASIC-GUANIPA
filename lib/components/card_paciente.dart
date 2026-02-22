import 'package:flutter/material.dart';
import 'package:asis_guanipa_frontend/models/paciente.dart';

class CardPaciente extends StatelessWidget {
  final PacienteData pacienteData;

  const CardPaciente({super.key, required this.pacienteData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${pacienteData.paciente.nombre} ${pacienteData.paciente.apellido}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.badge,
              'Cédula: ${pacienteData.paciente.cedula}',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.cake,
              'Edad: ${pacienteData.edadAtencion} años',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.calendar_today,
              'Fecha: ${_formatDate(pacienteData.fecha)}',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.medical_services,
              'Diagnóstico: ${pacienteData.diagnostico}',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.person_outline,
              'Atendido por: ${pacienteData.usuario.username}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }
}
