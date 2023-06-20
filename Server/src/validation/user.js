import admin from "../models/admin";
import user from "../models/user";
import worker from "../models/worker";

const { body } = require("express-validator");

const userRule = [
  body("name")
    .exists()
    .withMessage("Debe escribir un nombre")
    .isString()
    .withMessage("El nombre debe ser un texto")
    .isAlpha()
    .withMessage("El nombre debe contener letras"),
  body("last_name")
    .exists()
    .withMessage("Debe escribir los apellidos")
    .isString()
    .withMessage("Los apellidos deben ser en forma de texto")
    .isAlpha()
    .withMessage("Los apellidos solo deben contener letras"),
  body("email")
    .exists()
    .withMessage("Debe escribir un email")
    .isEmail()
    .withMessage("Escriba un email valido")
    .custom(async (value) => {
      const checkEmail = await user.findOne({ email: value });
      if (checkEmail) {
        return Promise.reject("Error");
      }
      
      checkEmail = await worker.findOne({ 'user.email': value });
      if (checkEmail) {
        return Promise.reject("Error");
      }

      checkEmail = await admin.findOne({ 'user.email': value });
      if (checkEmail) {
        return Promise.reject("Error");
      }

    })
    .withMessage("Este email ya fue registrado"),
  body("username")
    .exists()
    .withMessage("El nombre de usuario es requerido")
    .isString()
    .withMessage("El username es invalido")
    .custom(async (value) => {
      const checkUser = await user.findOne({ username: value });
      if (checkUser) {
        return Promise.reject("Error");
      }
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

const userRuleNotR = [
  body("name").isString().withMessage("Debe ser un string").optional(),
  body("last_name").isString().withMessage("Debe ser un string").optional(),
  body("password").optional().isString().withMessage("Debe ser un string"),
  body("ci").optional().isString().withMessage("Debe ser un string"),
  body("phoneNumber").optional().isNumeric().withMessage("Debe ser un numero"),
];

const loginRule = [
  body("username")
    .exists()
    .withMessage("Escriba el nombre de usuario")
    .isEmail("El username no es valido"),

  body("password").exists().withMessage("Debe escribir una contraseña"),
];

export { userRule, userRuleNotR, loginRule };
