class PacienteResponse {
  final bool success;
  final List<Paciente> data;
  final int total;

  PacienteResponse({required this.success, required this.data, this.total = 0});

  factory PacienteResponse.fromJson(Map<String, dynamic> json) {
    return PacienteResponse(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? (json['data'] as List).map((e) => Paciente.fromJson(e)).toList()
          : [],
      total: json['total'] ?? 0,
    );
  }
}

class Paciente {
  final int id;
  final String nombre;
  final String apellido;
  final String cedula;
  final String fechaNacimiento;
  final String sexo;
  final String? telefono;
  final String? direccion;
  final String? nombreRepresentante;
  final String? apellidoRepresentante;
  final String? cedulaRepresentante;
  final String? telefonoRepresentante;
  final String? createdAt;
  final String? updatedAt;

  Paciente({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.fechaNacimiento,
    required this.sexo,
    this.telefono,
    this.direccion,
    this.nombreRepresentante,
    this.apellidoRepresentante,
    this.cedulaRepresentante,
    this.telefonoRepresentante,
    this.createdAt,
    this.updatedAt,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      cedula: json['cedula'] ?? '',
      fechaNacimiento: json['fecha_nacimiento'] ?? '',
      sexo: json['sexo'] ?? '',
      telefono: json['telefono'],
      direccion: json['direccion'],
      nombreRepresentante: json['nombre_representante'],
      apellidoRepresentante: json['apellido_representante'],
      cedulaRepresentante: json['cedula_representante'],
      telefonoRepresentante: json['telefono_representante'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Usuario {
  final String username;

  Usuario({required this.username});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(username: json['username'] ?? '');
  }
}
