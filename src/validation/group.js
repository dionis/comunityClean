import group from "../models/group";

const { body } = require("express-validator");

const groupRule = [
  body("gNumber", "Debe ser un numero")
    .exists()
    .withMessage("Debe escribir el numero de la brigada")
    .isNumeric()
    .withMessage("El dato debe ser un numero")
    .custom(async (value) => {
      const checkGroup = await group.findOne({ gNumber: value });
      if (checkGroup) {
        return Promise.reject("Error");
      }
    })
    .withMessage("El numero ya esta registrado"),

  body("medium", "Los medios de la brigada tienen que ser de tipo string")
    .exists()
    .isString(),
  body("quantity", "La cantidad de trabajadores tiene que ser un número")
    .exists()
    .isNumeric(),
];

const groupRuleNotR = [
  body("gNumber", "Debe ser un numero")
    .optional()
    .isNumeric()
    .withMessage("El dato debe ser un numero")
    .custom(async (value) => {
      const checkGroup = await group.findOne({ gNumber: value });
      if (checkGroup) {
        return Promise.reject("Error");
      }
    })
    .withMessage("Este usuario ya fue registrado"),

  body("medium", "Los medios de la brigada tienen que ser de tipo string")
    .optional()
    .isString(),
  body("quantity", "La cantidad de trabajadores tiene que ser un número")
    .optional()
    .isNumeric(),
];

export { groupRule, groupRuleNotR };
