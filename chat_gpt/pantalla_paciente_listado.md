# Pantalla de listado de pacientes

recuerdas que me ayudaste hacer la pantalla paciente, en el archivo /lib/screen/nominal_register bueno no te pase la direccion correcta de la api y quiero que me ayudes a corregirla:

* Listado de pacientes:
```bash
curl -X 'GET' \
  'https://api.asic-guanipa.online/api/pacientes/listado' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer {{ token }}'
```

y devuelve la siguiente respuesta:
```json

{
  "success": true,
  "data": [
    {
      "id": 5,
      "nombre": "Camila",
      "apellido": "Camico",
      "cedula": "23894099",
      "fecha_nacimiento": "1990-05-15",
      "sexo": "M",
      "telefono": "04141112233",
      "direccion": "Calle Falsa 123",
      "nombre_representante": null,
      "apellido_representante": null,
      "cedula_representante": null,
      "telefono_representante": null,
      "createdAt": "2026-02-20T20:51:33.827Z",
      "updatedAt": "2026-02-20T20:51:33.827Z"
    },
   
  ],
  "total": 11
}

quiero que en el archivo /lib/screen/nominal_register que me carge el listado de pacientes