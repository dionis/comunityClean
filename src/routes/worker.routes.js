import express, { Router } from "express";
import group from "../models/group";
import user, { userSchema } from "../models/user";
import Worker from "../models/worker";
import { workerRule, workerRuleNotR } from "../validation/worker";
const { validationResult, param } = require("express-validator");

const workers = Router();
workers.use(express.json());

workers.post("/api/v1/workers", workerRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const newWorker = Worker(req.body);
    const workerSaved = await newWorker.save();
    res.send(workerSaved);
  } catch (error) {
    res.json({ message: error });
  }
});

workers.get("/api/v1/workers", async (req, res) => {
  try {
    const worker = await Worker.find();
    const test = await group.findOne({gNumber:4})
    console.log(test);

    res.send(worker);
  } catch (error) {
    res.json({ message: error });
  }
});

workers.get(
  "/api/v1/workers/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const worker = await Worker.findById(req.params.id);
      res.send(worker);
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

workers.put(
  "/api/v1/workers/:id",
  [param("id", "El id debe ser un string").exists().isString()].concat(
    workerRuleNotR
  ),
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const { user, isBoss, gNumber } = req.body
      if (user.name !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { name: user.name }
        );
      }
      if (lastName !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { lastName: lastName }
        );
      }
      if (username !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { username: username }
        );
      }
      if (password !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { password: password }
        );
      }
      if (ci !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { ci: ci }
        );
      }
      if (phoneNumber !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { phoneNumber: phoneNumber }
        );
      }

      res.send(await Worker.findById(req.params.id));
    } catch (error) {
      res.json({ message: error });
    }
  }
);

workers.delete(
  "/api/v1/workers/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const removedRequests = await Worker.deleteOne({
        _id: req.params.id,
      });
      res.send(removedRequests);
    } catch (error) {
      res.json({ message: error });
    }
  }
);

export default workers;
