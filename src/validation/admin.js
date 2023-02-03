const { body } = require("express-validator");
import admin from "../models/admin";

const requireVal = (path) => [
  body(`${path}.name`)
    .exists()
    .withMessage("Debe escribir un nombre")
    .isString()
    .withMessage("El nombre debe ser un texto")
    .isAlpha()
    .withMessage("El nombre debe contener letras"),
  body(`${path}.last_name`)
    .exists()
    .withMessage("Debe escribir los apellidos")
    .isString()
    .withMessage("Los apellidos deben ser en forma de texto")
    .isAlpha()
    .withMessage("Los apellidos solo deben contener letras"),
  body(`${path}.email`)
    .exists()
    .withMessage("Debe escribir el email")
    .isEmail()
    .withMessage("El formato del email es incorrecto"),
  body(`${path}.username`)
    .exists()
    .withMessage("El nombre de usuario es requerido")
    .isString()
    .withMessage("El nombre de usuario debe ser un String")
    .custom(async (value) => {
      const checkUser = await admin.findOne({ 'user.username': value });
      if (checkUser != null) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este usuario ya fue registrado"),

  body(`${path}.password`)
    .exists()
    .withMessage("La contraseña es requerida")
    .isString(),
  body(`${path}.ci`)
    .exists()
    .withMessage("El numero de carnet es requerido")
    .isString()
    .isLength({ min: 11, max: 11 })
    .withMessage("El numero de carnet tiene que tener 11 caracteres"),
  body(`${path}.phoneNumber`)
    .exists()
    .withMessage("El numero de telefono es requerido")
    .isNumeric()
    .withMessage("El dato debe ser numerico"),
];
const notRequireVal = (path) => [
  body(`${path}.name`)
    .optional()
    .isString()
    .withMessage("El nombre debe ser un texto")
    .isAlpha()
    .withMessage("El nombre debe contener letras"),
  body(`${path}.last_name`)
    .optional()
    .isString()
    .withMessage("Los apellidos deben ser en forma de texto")
    .isAlpha()
    .withMessage("Los apellidos solo deben contener letras"),
  body(`${path}.password`).optional().isString(),
  body(`${path}.ci`)
    .optional()
    .isString()
    .isLength({ min: 11, max: 11 })
    .withMessage("El numero de carnet tiene que tener 11 caracteres"),
  body(`${path}.phoneNumber`)
    .optional()
    .isNumeric()
    .withMessage("El dato debe ser numerico"),
];

const adminRule = [
  ...requireVal("user"),
  body("local")
    .exists()
    .withMessage("El local es requerido")
    .isString()
    .withMessage("El local tiene que ser un dato de tipo texto"),
  body("medium")
    .exists()
    .withMessage("El medio de telefono es requerido")
    .isString()
    .withMessage("El dato debe ser de tipo texto"),
];

const adminRuleNotR = [
  ...notRequireVal("user"),
  body("local")
    .optional()
    .isString()
    .withMessage("El local tiene que ser un dato de tipo texto"),
  body("medium")
    .optional()
    .isString()
    .withMessage("El dato debe ser de tipo texto"),
];

export { adminRule, adminRuleNotR };
