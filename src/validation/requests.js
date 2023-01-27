const { body } = require("express-validator");

const requestRule = [
  body("amountGarbage")
    .exists()
    .withMessage("Escriba la cantidad de basura")
    .isNumeric()
    .withMessage("La cantidad debe ser un numero"),
  body("stat", "El estado debe ser True o False")
    .exists()
    .withMessage("Campo requerido")
    .isBoolean()
    .withMessage("El estado es de tipo booleano"),
  body("image_url", "El formato de la url es incorrecto")
    .exists()
    .withMessage("El link de la imagen es requerido")
    .isURL()
    .withMessage("Debe escribir el link correctamente"),
  body("locations", "La dirección debe ser en formato de texto")
    .exists()
    .withMessage("Campo obligatorio")
    .isString()
    .withMessage("La direccion tiene que ser de tipo texto"),
];

export default requestRule;
