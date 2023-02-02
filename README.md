# Documentacion de la API


## Estructura del Código
La estructura de la API es la siguiente 
    
    src-|        
            models-|
                admin.js
                group.js
                notification.js
                request.js
                stats.js
                user.js
                worker.js
         routes-|
                admin.routes.js
                group.routes.js   
                index.routes.js   
                notifications.routes.js   
                request.routes.js
                stats.routes.js
                user.routes.js 
                worker.routes.js
         validation-|
                admin.js
                group.js
                notification.js
                request.js
                stats.js
                user.js
                worker.js
         views-|

* En la carpeta models están los modelos creados con mongoose para cada entidad que se  guardará en nuestra base de datos de mongodb
* En la carpeta routes estan los endpoints o rutas a las cuales les haremos las peticiones
* En validation están las reglas que debe seguir la validacion de cada atributo de las entidades

## Instalación de los modulos 

```bash
npm run install
```
## Iniciar la API
Para iniciar la API primeramente hay que iniciar el servicio de Mongo DB con el siguiente comando

```bash
mongod --ipv6
```
Luego de iniciar mongo, abrimos la consola y nos desplazamos hasta la carpeta del proyecto y escribimos

```bash
npm run dev
```
Cuando nos envie el mensaje de conexion satisfactoria podremos comenzar a hacer las peticiones para probar la API

```bash
npm run install
```

## Endpoints: 
### Request
POST http://localhost:8000/api/v1/requests
Content-Type: application/json

{
  "amountGarbage": ,
  "stat": ,
  "image_url": ,
  "locations":
}


GET http://localhost:8000/api/v1/requests

GET http://localhost:8000/api/v1/requests/id


PUT http://localhost:8000/api/v1/requests/id
Content-Type: application/json

{
  "amountGarbage": ,
  "stat": ,
  "image_url": ,
  "locations":
}


DELETE http://localhost:8000/api/v1/requests/id

### Notifications


POST http://localhost:8000/api/v1/notifications
Content-Type: application/json

{
  "message": ,
  "isSended": ,
  "isRecived":
}


GET http://localhost:8000/api/v1/notifications


GET http://localhost:8000/api/v1/notifications/id


PUT http://localhost:8000/api/v1/notifications/id
Content-Type: application/json

{
  "message": ,
  "isSended": ,
  "isRecived":
}

DELETE http://localhost:8000/api/v1/notifications/id


### Group


POST http://localhost:8000/api/v1/groups
Content-Type: application/json

{
  "gNumber": ,
  "medium": ,
  "quantity":
}


GET http://localhost:8000/api/v1/groups


GET http://localhost:8000/api/v1/groups/id


PUT http://localhost:8000/api/v1/groups/id
Content-Type: application/json

{
  "gNumber": ,
  "medium": ,
  "quantity":
}


DELETE http://localhost:8000/api/v1/groups/id


### User

POST http://localhost:8000/api/v1/users
Content-Type: application/json

{
  "name": ,
  "lastName": ,
  "username": ,
  "password": ,
  "ci": ,
  "phoneNumber":
}


GET http://localhost:8000/api/v1/users


GET http://localhost:8000/api/v1/users/id


PUT http://localhost:8000/api/v1/users/id
Content-Type: application/json

{
  "name": ,
  "lastName": ,
  "username": ,
  "password": ,
  "ci": ,
  "phoneNumber":
}

DELETE http://localhost:8000/api/v1/users/id


### Admin
Cotent-Type: application/json

{
	
	"user":{
		"name": "Claudia",
		"last_name" : "Queipo",
		"username": "qwerty",
		"password": "ekisde",
		"ci": "02060561797" ,
		"phoneNumber": 55326313
	},
		"local": "Laboratorio 1",
		"medium": "Laptop"
}







