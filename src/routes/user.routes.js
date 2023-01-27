import express, { Router } from "express";
import User from "../models/user";
import userRule from "../validation/user";
const { body, validationResult, param } = require("express-validator");

const users = Router();
users.use(express.json());

users.post("/api/v1/users", userRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const newUser = user(req.body);
    const userSaved = await newUser.save();
    res.send(userSaved);
  } catch (error) {
    res.json({ message: error });
  }
});

users.get("/api/v1/users", async (req, res) => {
  try {
    const user = await user.find();
    res.send(user);
  } catch (error) {
    res.json({ message: error });
  }
});

users.get(
  "/api/v1/users/:id",
  [param("id", "El id debe ser un string").exists().isNumeric()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const user = await user.findById(req.params.id);
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
  [param("id", "El id debe ser un string").exists().isNumeric(), userRule],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const { name, lastName, username, password, ci, phoneNumber } = req.body;
      if (name !== undefined) {
        await user.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { name: name }
        );
      }
      if (lastName !== undefined) {
        await user.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { lastName: lastName }
        );
      }
      if (username !== undefined) {
        await user.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { username: username }
        );
      }
      if (password !== undefined) {
        await user.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { password: password }
        );
      }
      if (ci !== undefined) {
        await user.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { ci: ci }
        );
      }
      if (phoneNumber !== undefined) {
        await user.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { phoneNumber: phoneNumber }
        );
      }

      res.send(await user.findById(req.params.id));
    } catch (error) {
      res.json({ message: error });
    }
  }
);

users.delete(
  "/api/v1/users/:id",
  [param("id", "El id debe ser un string").exists().isNumeric()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const removedRequests = await user.deleteOne({
        _id: req.params.id,
      });
      res.send(removedRequests);
    } catch (error) {
      res.json({ message: error });
    }
  }
);

export default users;
