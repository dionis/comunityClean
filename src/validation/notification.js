const { body } = require("express-validator");

const notificationRule = [
  body("message", "El mensaje debe ser un texto").exists().isString(),
  body("isSended", "El estado de enviado debe ser True o False")
    .exists()
    .isBoolean(),
  body("isRecived", "El estado de recivido debe ser True o False")
    .optional()
    .isBoolean(),
];
const notificationRuleNotR = [
  body("message", "El mensaje debe ser un texto").optional().isString(),
  body("isSended", "El estado de enviado debe ser True o False")
    .optional()
    .isBoolean(),
  body("isRecived", "El estado de recivido debe ser True o False")
    .optional()
    .isBoolean(),
];

export {notificationRule, notificationRuleNotR};
