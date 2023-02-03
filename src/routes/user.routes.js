import express, { Router } from "express";
import User from "../models/user";
import { userRule, userRuleNotR, loginRule } from "../validation/user";
import bodyparser from "body-parser";
const { validationResult, param } = require("express-validator");

const bcrypt = require("bcrypt");
const users = Router();
users.use(express.json());
users.use(bodyparser.urlencoded({ extended: false }));
users.use(bodyparser.json());

// Registro del usuario
users.post("/api/v1/users/register", userRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const salt = await bcrypt.genSalt(10);
    const password = await bcrypt.hash(req.body.password, salt);

    const newUser = User(req.body);
    newUser.password = password;
    const userSaved = await newUser.save();
    res.send({message: `El usuario ${userSaved.username} se ha registrado con éxito`});
  } catch (error) {
    res.json({ message: error });
  }
});

// Login del usuario
users.post("/api/v1/users/login", loginRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const validUser = await User.findOne({ username: req.body.username });
    if (!validUser) {
      return res.status(400).json({ error: "El nombre de usuario no existe" });
    }

    const validPassword = await bcrypt.compare(
      req.body.password,
      validUser.password
    );
    if (!validPassword) {
      return res.status(400).json({ error: "La contraseña es incorrecta" });
    }

    res.send({ message: "Login exitoso, Bienvenido" });
  } catch (error) {
    console.log(error);
    res.json({ error });
  }
});

users.get("/api/v1/users", async (req, res) => {
  try {
    const user = await User.find();
    res.send(user);
  } catch (error) {
    res.json({ message: error });
  }
});

users.get(
  "/api/v1/users/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const user = await User.findById(req.params.id);
      res.send(user);
    } catch (error) {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      } else {
        res.json({ message: error });
      }
    }
  }
);

users.put(
  "/api/v1/users/:id",
  [param("id").exists().withMessage("EL id es requerido").isString()].concat(
    userRuleNotR
  ),
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const { name, lastName, username, password, ci, phoneNumber } = req.body;

      if (name !== undefined) {
        await User.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { name: name }
        );
      }
      if (lastName !== undefined) {
        await User.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { lastName: lastName }
        );
      }
      if (username !== undefined) {
        await User.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { username: username }
        );
      }
      if (password !== undefined) {
        await User.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { password: password }
        );
      }
      if (ci !== undefined) {
        await User.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { ci: ci }
        );
      }
      if (phoneNumber !== undefined) {
        await User.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { phoneNumber: phoneNumber }
        );
      }

      res.send(await User.findById(req.params.id));
    } catch (error) {
      res.json({ message: error });
    }
  }
);

users.delete(
  "/api/v1/users/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const removedRequests = await User.deleteOne({
        _id: req.params.id,
      });
      res.send(removedRequests);
    } catch (error) {
      res.json({ message: error });
    }
  }
);

export default users;
