import express, { Router } from "express";
import Group from "../models/group";
import { groupRule, groupRuleNotR } from "../validation/group";
const { validationResult, param } = require("express-validator");

const groups = Router();
groups.use(express.json());

groups.post("/api/v1/groups", groupRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const newGroup = Group(req.body);
    const groupSaved = await newGroup.save();
    res.send(groupSaved);
  } catch (error) {
    res.json({ message: error });
  }
});

groups.get("/api/v1/groups", async (req, res) => {
  try {
    const group = await Group.find();
    res.send(group);
  } catch (error) {
    res.json({ message: error });
  }
});

groups.get(
  "/api/v1/groups/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const group = await Group.findById(req.params.id);
      res.send(group);
    } catch (error) {
      res.json({ message: error });
    }
  }
);

groups.put(
  "/api/v1/groups/:id",
  [param("id", "El id debe ser un string").exists().isString()].concat(
    groupRuleNotR
  ),
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const { gNumber, medium, quantity } = req.body;
      if (gNumber !== undefined) {
        await Group.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { gNumber: gNumber }
        );
      }
      if (medium !== undefined) {
        await Group.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { medium: medium }
        );
      }
      if (quantity !== undefined) {
        await Group.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { quanti: quantity }
        );
      }

      res.send(await Group.findById(req.params.id));
    } catch (error) {
      res.json({ message: error });
    }
  }
);

groups.delete(
  "/api/v1/groups/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const removedRequests = await Group.deleteOne({
        _id: req.params.id,
      });
      res.send(removedRequests);
    } catch (error) {
      res.json({ message: error });
    }
  }
);

export default groups;
