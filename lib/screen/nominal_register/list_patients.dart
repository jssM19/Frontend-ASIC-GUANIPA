import 'package:flutter/material.dart';
import 'package:asis_guanipa_frontend/components/card_simple.dart';

class ListPatients extends StatelessWidget {
  const ListPatients({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount:
            1, // Número de pacientes (puedes cambiarlo según tus necesidades)
        itemBuilder: (context, index) {
          return const CardSimple(); // Aquí puedes reemplazar con tu widget personalizado para mostrar la información del paciente
        },
      ),
    );
  }
}
