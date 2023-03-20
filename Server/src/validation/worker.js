const { body, check } = require("express-validator");
import group from "../models/group";
import user from "../models/user";
import admin from "../models/admin";
import worker from "../models/worker";

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
    .withMessage("El formato del email es incorrecto")
    .custom(async (value) => {
      let checkEmail = await user.findOne({ email: value });
      if (checkEmail!=null) {
        return Promise.reject("Error");
      }

      checkEmail = await worker.findOne({ "user.email": value });
      if (checkEmail!=null) {
        return Promise.reject("Error");
      }

      checkEmail = await admin.findOne({ "user.email": value });
      if (checkEmail!=null) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este email ya fue registrado"),
  body(`${path}.username`)
    .exists()
    .withMessage("El nombre de usuario es requerido")
    .isString()
    .withMessage("El nombre de usuario debe ser un String")
    .custom(async (value) => {
      const checkUser = await user.findOne({ username: value });
      if (checkUser != null) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este usuario ya fue registrado")
    .custom(async (value) => {
      const checkUser = await worker.findOne({ "user.username": value });
      if (checkUser != null) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este trabajador ya fue registrado"),
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

const workerRule = [
  ...requireVal("user"),
  body("isBoss")
    .exists()
    .withMessage("El campo es requerido")
    .isBoolean()
    .withMessage("El dato debe ser un booleano"),
  body("gNumber")
    .exists()
    .withMessage("El numero de brigada es requerido")
    .isNumeric()
    .withMessage("El dato debe ser numerico")
    .custom(async (value) => {
      const checkGroup = await group.findOne({ gNumber: value });
      if (checkGroup == null) {
        return Promise.reject("Error");
      }
    })
    .withMessage("El numero no existe"),
];

const workerRuleNotR = [
  ...notRequireVal("user"),
  body("isBoss")
    .optional()
    .isBoolean()
    .withMessage("El dato debe ser un booleano"),
  body("gNumber")
    .optional()
    .isNumeric()
    .withMessage("El dato debe ser numerico")
    .custom((value) => {
      return group.findOne({ gNumber: value }, (result) => {
        if (result) {
          return Error("xd");
        }
      });
    })
    .withMessage("El numero no esta registrado"),
];

export { workerRule, workerRuleNotR };
