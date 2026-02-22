class PacienteResponse {
  final bool success;
  final List<PacienteData> data;

  PacienteResponse({required this.success, required this.data});

  factory PacienteResponse.fromJson(Map<String, dynamic> json) {
    return PacienteResponse(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? (json['data'] as List).map((e) => PacienteData.fromJson(e)).toList()
          : [],
    );
  }
}

class PacienteData {
  final int id;
  final int pacienteId;
  final String diagnostico;
  final String fecha;
  final int edadAtencion;
  final int idUsuarioRegistra;
  final String? createdAt;
  final String? updatedAt;
  final Paciente paciente;
  final Usuario usuario;

  PacienteData({
    required this.id,
    required this.pacienteId,
    required this.diagnostico,
    required this.fecha,
    required this.edadAtencion,
    required this.idUsuarioRegistra,
    this.createdAt,
    this.updatedAt,
    required this.paciente,
    required this.usuario,
  });

  factory PacienteData.fromJson(Map<String, dynamic> json) {
    return PacienteData(
      id: json['id'] ?? 0,
      pacienteId: json['paciente_id'] ?? 0,
      diagnostico: json['diagnostico'] ?? '',
      fecha: json['fecha'] ?? '',
      edadAtencion: json['edad_atencion'] ?? 0,
      idUsuarioRegistra: json['id_usuario_registra'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      paciente: Paciente.fromJson(json['paciente'] ?? {}),
      usuario: Usuario.fromJson(json['usuario'] ?? {}),
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
