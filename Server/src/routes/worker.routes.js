import express, { Router } from "express";
import Worker from "../models/worker";
import bcrypt from "bcrypt";
import bodyparser from "body-parser";

import { workerRule, workerRuleNotR } from "../validation/worker";
const { validationResult, param } = require("express-validator");

const workers = Router();
workers.use(express.json());
workers.use(bodyparser.urlencoded({ extended: false }));
workers.use(bodyparser.json());

workers.post("/api/v1/workers/register", workerRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const salt = await bcrypt.genSalt(10);
    const password = await bcrypt.hash(req.body.user.password, salt);

    const newWorker = Worker(req.body);
    newWorker.user.password = password;
    const workerSaved = await newWorker.save();

    res.status(200).json({
      message: `El usuario ${workerSaved.user.username} se ha registrado con éxito`,
    });
  } catch (error) {
    console.log(error);
    res.status(400).json({ message: error });
  }
});

workers.get("/api/v1/workers", async (req, res) => {
  try {
    const worker = await Worker.find();

    res.status(200).json(worker);
  } catch (error) {
    res.status(400).json({ message: error });
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
      res.status(200).json(worker);
    } catch (error) {
      res.status(400).json({ message: error });
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
      const { user, isBoss, gNumber } = req.body;
      if (user.name !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.name": user.name }
        );
      }
      if (user.lastName !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.lastName": lastName }
        );
      }
      if (user.password !== undefined) {
        const salt = await bcrypt.genSalt(10);
        const pass = await bcrypt.hash(password, salt);
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.password": pass }
        );
      }
      if (user.ci !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.ci": ci }
        );
      }
      if (user.phoneNumber !== undefined) {
        await Worker.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { "user.phoneNumber": phoneNumber }
        );
      }

      res.status(200).json(await Worker.findById(req.params.id));
    } catch (error) {
      res.status(400).json({ message: error });
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
      res.status(200).json(removedRequests);
    } catch (error) {
      res.status(400).json({ message: error });
    }
  }
);

export default workers;
