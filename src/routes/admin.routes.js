import express, { Router } from "express";
import Admin from "../models/admin";
import { adminRule, adminRuleNotR } from "../validation/admin";
const { validationResult, param } = require("express-validator");

const admins = Router();
admins.use(express.json());

admins.post("/api/v1/admins", adminRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const newAdmin = Admin(req.body);
    const adminSaved = await newAdmin.save();
    res.send(adminSaved);
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
      const { name, lastName, username, password, ci, phoneNumber } = req.body;
      if (name !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { name: name }
        );
      }
      if (lastName !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { lastName: lastName }
        );
      }
      if (username !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { username: username }
        );
      }
      if (password !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { password: password }
        );
      }
      if (ci !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { ci: ci }
        );
      }
      if (phoneNumber !== undefined) {
        await Admin.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { phoneNumber: phoneNumber }
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
