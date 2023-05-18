import express, { Router } from "express";
import User from "../models/user";
import Worker from "../models/worker";
import { userRule, userRuleNotR, loginRule } from "../validation/user";
import bodyparser from "body-parser";
const { validationResult, param } = require("express-validator");
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const bcrypt = require("bcrypt");
const users = Router();
users.use(express.json());
users.use(bodyparser.urlencoded({ extended: false }));
users.use(bodyparser.json());

// Registro del usuario
users.post("/api/v1/users/register", async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    let { name, last_name, email, username, password, ci, rolNum, phoneNumber } =
      req.body;

    const salt = await bcrypt.genSalt(10);
    password = await bcrypt.hash(password, salt);

    const userSaved = await prisma.user.create({
      data: {
        name,
        last_name,
        email,
        username,
        password,
        ci,
        rolNum,
        phoneNumber,
      },
    });

    res.json(userSaved);
  } catch (error) {
    console.log(error);
    res.json(error);
  }
});

// Login del usuario
users.post("/api/v1/users/login", loginRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const validUser = await prisma.user.findOne({ email: req.body.email });
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
    const user =  await prisma.user.findMany();
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

      const { name, lastName, email, password, ci, phoneNumber } = req.body;

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
      if (password !== undefined) {
        const salt = await bcrypt.genSalt(10);
        const pass = await bcrypt.hash(password, salt);

        await User.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { password: pass }
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
