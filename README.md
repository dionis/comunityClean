# comunityClean
## Iniciar la API
Crear en la carpeta Server un archivo .env que contenga la siguiente linea de código

DATABASE_URL="postgresql://postgres:1234@localhost:5432/cityclean"

en username colocaremos el nombre de nuestro usuario en postgres y en password la contraseña correspondiente.

Agregamos a el archivo .env el **APIKEY** de Stripe para poder ejecutar las compras online para luego ejecutar el comando:

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
