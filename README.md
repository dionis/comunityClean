# comunityClean
## Iniciar la API
Crear en la carpeta Server un archivo .env que contenga la siguiente linea de código

DATABASE_URL="postgresql://postgres:1234@localhost:5432/cityclean"

en username colocaremos el nombre de nuestro usuario en postgres y en password la contraseña correspondiente para luego ejecutar el comando

```bash
npx prisma generate
```
Luego abrimos la consola y escribimos

```bash
npm run dev
```
