import user from "../models/user";

const { body } = require("express-validator");

const userRule = [
  body("name")
    .exists()
    .withMessage("Debe escribir un nombre")
    .isString()
    .withMessage("El nombre debe ser un texto")
    .isAlpha()
    .withMessage("El nombre debe contener letras"),
  body("lastName")
    .exists()
    .withMessage("Debe escribir los apellidos")
    .isString()
    .withMessage("Los apellidos deben ser en forma de texto")
    .isAlpha()
    .withMessage("Los apellidos solo deben contener letras"),
  body("username")
    .exists()
    .withMessage("El nombre de usuario es requerido")
    .isString()
    .custom((value) => {
      return user.findOne({ username: value }, (result) => {
        if (result) {
          throw Error("ERROR!");
        }
      });
    })
    .withMessage("Este usuario ya fue registrado"),
  body("password")
    .exists()
    .withMessage("La contraseña es requerida")
    .isString(),
  body("ci")
    .exists()
    .withMessage("El numero de carnet es requerido")
    .isString()
    .isLength({ min: 11, max: 11 })
    .withMessage("El numero de carnet tiene que tener 11 caracteres"),
  body("phoneNumber", "La cantidad de trabajadores tiene que ser un número")
    .exists()
    .withMessage("El numero de telefono es requerido")
    .isNumeric()
    .withMessage("El dato debe ser numerico"),
];

export default userRule;
