# Documentacion de la API

## Instalación de los modulos 

```bash
npm install
```
## Iniciar la API

### MongoDB

```bash
mongod --ipv6
```
### PostgreSQL
Crear en la carpeta Server un archivo .env que contenga la siguiente linea de código

DATABASE_URL="postgresql://postgres:1234@localhost:5432/cityclean"

en username colocaremos el nombre de nuestro usuario en postgres y en password la contraseña correspondiente para luego ejecutar el comando

```bash
npx prisma generate
```

Generamos la migración y creamos las tablas en la base de datos
```bash
npx prisma migrate dev --name init
```
Luego abrimos la consola y escribimos

```bash
npm run dev
```
Cuando nos envie el mensaje de conexion satisfactoria podremos comenzar a hacer las peticiones para probar la API

```bash
npm run install
```
