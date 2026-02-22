# Pantalla de paciente

Tengo el siguiente endpoints que nos ayudaran para la creacion de la pantalla indicada:

* Listado de paciente 
```bash
curl -X 'GET' \
  'https://api.asic-guanipa.online/api/pacientes' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer {{ token }}'
```

y devuelve la siguiente respuesta:
```json
{
  "success": true,
  "data": [
    {
      "id": 0,
      "paciente_id": 0,
      "diagnostico": "string",
      "fecha": "2026-02-22",
      "edad_atencion": 0,
      "id_usuario_registra": 0,
      "created_at": "2026-02-22T21:19:10.831Z",
      "updated_at": "2026-02-22T21:19:10.831Z",
      "paciente": {
        "id": 0,
        "nombre": "string",
        "apellido": "string",
        "cedula": "string",
        "fecha_nacimiento": "2026-02-22",
        "sexo": "M",
        "telefono": "string",
        "direccion": "string",
        "nombre_representante": "string",
        "apellido_representante": "string",
        "cedula_representante": "string",
        "telefono_representante": "string",
        "created_at": "2026-02-22T21:19:10.831Z",
        "updated_at": "2026-02-22T21:19:10.831Z"
      },
      "usuario": {
        "username": "string"
      }
    }
  ]
}
```

quiero que en el archivo /lib/screen/nominal_register crear los widgets correspondeste al listado de pacientes me gustaria un scroll infinito. el endpoint de busqueda puede filtrar por cedula y fecha ejemplo ?fecha=2024-11-30 o ?cedula=valor