import express, { Router } from "express";
import Admin from "../models/admin";
import { adminRule, adminRuleNotR } from "../validation/admin";
const { validationResult, param } = require("express-validator");
import bcrypt from "bcrypt";
import bodyparser from "body-parser";

const admins = Router();
admins.use(express.json());
admins.use(bodyparser.urlencoded({ extended: false }));
admins.use(bodyparser.json());

admins.post("/api/v1/admins/register", adminRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const salt = await bcrypt.genSalt(10);
    const password = await bcrypt.hash(req.body.user.password, salt);

    const newAdmin = Admin(req.body);
    newAdmin.user.password = password;
    const adminSaved = await newAdmin.save();
    res.send({
      message: `El usuario ${adminSaved.user.username} se ha registrado con éxito`,
    });
  } catch (error) {
    res.json({ message: error });
  }
});

admins.get("/api/v1/admins", async (req, res) => {
  try {
    const admin = await Admin.find();
    res.send(admin);
  } catch (error) {
    res.json({ message: error });
  }
});

admins.get(
  "/api/v1/admins/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const admin = await Admin.findById(req.params.id);
      res.send(admin);
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

admins.put(
  "/api/v1/admins/:id",
  [param("id", "El id debe ser un string").exists().isString()].concat(
    adminRuleNotR
  ),
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const { user, local, medium } = req.body;
      if (user.name !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.name": user.name }
        );
      }
      if (user.lastName !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.lastName": user.lastName }
        );
      }

      if (user.password !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.password": user.password }
        );
      }
      if (user.ci !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.ci": user.ci }
        );
      }
      if (user.phoneNumber !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.phoneNumber": user.phoneNumber }
        );
      }
      if (local !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { local: local }
        );
      }
      if (medium !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { medium: medium }
        );
      }

      res.send(await Admin.findById(req.params.id));
    } catch (error) {
      res.json({ message: error });
    }
  }
);

admins.delete(
  "/api/v1/admins/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const removedRequests = await Admin.deleteOne({
        _id: req.params.id,
      });
      res.send(removedRequests);
    } catch (error) {
      res.json({ message: error });
    }
  }
);

export default admins;
