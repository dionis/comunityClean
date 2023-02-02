import admin from "../models/admin";
import group from "../models/group";
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
  body("last_name")
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
    .withMessage("El nombre de usuario debe ser un String")
    .custom(async (value) => {
      const checkUser = await user.findOne({ username: value });
      if (checkUser) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este usuario ya fue registrado")
    .custom(async (value) => {
      const checkUser = await group.findOne({ username: value });
      if (checkUser != null) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este usuario ya fue registrado")
    .custom(async (value) => {
      const checkUser = await admin.findOne({ username: value });
      if (checkUser != null) {
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
  body("username")
    .optional()
    .isString()
    .withMessage("Debe ser un string")
    .custom(async (value) => {
      const checkUser = await user.findOne({ username: value });
      if (checkUser != null) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este usuario ya fue registrado")
    .custom(async (value) => {
      const checkUser = await worker.findOne({ username: value });
      if (checkUser != null) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este usuario ya fue registrado")
    .custom(async (value) => {
      const checkUser = await admin.findOne({ username: value });
      if (checkUser != null) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este usuario ya fue registrado"),
  body("password").optional().isString().withMessage("Debe ser un string"),
  body("ci").optional().isString().withMessage("Debe ser un string"),
  body("phoneNumber").optional().isNumeric().withMessage("Debe ser un numero"),
];

export { userRule, userRuleNotR };
