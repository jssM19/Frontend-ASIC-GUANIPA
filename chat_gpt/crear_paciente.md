# Crear paciente

Tengo el siguiente endpoints que nos ayudara para crear paciente, quiero que en el archivo /lib/screen/nominal_register  me agregues un boton flotante con su icono de agregar, ese boton va abrir un dialogo que va tener un formulario con los 
siguientes inputs: nombre, apellido, cedula, fecha de nacimiento, sexo, telefono y direccion y claro con su boton de crear paciente:

* Crear paciente 

```bash

curl -X 'POST' \
  'https://api.asic-guanipa.online/api/pacientes' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOiJqZXNzbG9tYXNiZWxsb0BnbWFpbC5jb20iLCJ1c2VybmFtZSI6Imptb3Jlbm8iLCJpYXQiOjE3NzIyMjgzODEsImV4cCI6MTc3MjMxNDc4MX0.lF-5aSwddE8VTIT-wgZphNxqqNnAqD7QCK1pDUimAg8' \
  -H 'Content-Type: application/json' \
  -d '{
  "nombre": "Juan",
  "apellido": "Perez",
  "cedula": "12345678",
  "fecha_nacimiento": "1990-05-15",
  "sexo": "M",
  "telefono": "04141112233",
  "direccion": "Calle Falsa 123"
}'

```

y de vuelve la siguente respuesta:

```json

{
  "success": true,
  "message": "Paciente registrado exitosamente",
  "data": {
    "patient": {
      "id": 1,
      "nombre": "Juan",
      "apellido": "Pérez",
      "cedula": "12345678",
      "fecha_nacimiento": "1990-05-15",
      "sexo": "M",
      "telefono": "04141112233",
      "direccion": "Calle Falsa 123",
      "nombre_representante": null,
      "apellido_representante": null,
      "cedula_representante": null,
      "telefono_representante": null,
      "createdAt": "2026-01-22T16:26:37.841Z",
      "updatedAt": "2026-02-23T21:38:12.282Z"
    }
  }
}


