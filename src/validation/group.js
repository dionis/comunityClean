const { body } = require("express-validator");

const groupRule = [
  body("gNumber", "Debe ser un numero")
    .exists()
    .withMessage("Debe escribir el numero de la brigada")
    .isNumeric()
    .withMessage("El dato debe ser un numero")
    .custom((value) => {
      return Group.findOne({ gNumber: value }, (result) => {
        if (result) {
          throw Error("ERROR!");
        }
      });
    })
    .withMessage("El numero ya esta registrado"),

  body("medium", "Los medios de la brigada tienen que ser de tipo string")
    .exists()
    .isString(),
  body("quantity", "La cantidad de trabajadores tiene que ser un número")
    .exists()
    .isNumeric(),
];

export default groupRule;
