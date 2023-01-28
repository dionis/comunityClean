import express, { Router } from "express";
import collectRequest from "../models/request";
import {requestRule,requestRuleNotR} from "../validation/requests";
const { validationResult, param } = require("express-validator");

const cRequests = Router();
cRequests.use(express.json());

cRequests.post("/api/v1/requests", requestRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const collectionRequest = collectRequest(req.body);
    const requestSaved = await collectionRequest.save();
    res.send(requestSaved);
  } catch (error) {
    res.json({ message: error });
  }
});

cRequests.get("/api/v1/requests", async (req, res) => {
  try {
    const requests = await collectRequest.find();
    res.send(requests);
  } catch (error) {
    res.json({ message: error });
  }
});

cRequests.get(
  "/api/v1/requests/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const requests = await collectRequest.findById(req.params.id);
      res.send(requests);
    } catch (error) {
      const errors = validationResult(req);

      res.json({ message: error });
    }
  }
);

cRequests.put(
  "/api/v1/requests/:id",
  [param("id", "El id debe ser un string").exists().isString()].concat(requestRuleNotR),
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const { amountGarbage, stat, image_url, locations } = req.body;
      if (amountGarbage !== undefined) {
        await collectRequest.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { amountGarbage: amountGarbage }
        );
      }
      if (stat !== undefined) {
        await collectRequest.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { stat: stat }
        );
      }
      if (image_url !== undefined) {
        await collectRequest.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { image_url: image_url }
        );
      }
      if (locations !== undefined) {
        await collectRequest.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { locations: locations }
        );
      }

      res.send(await collectRequest.findById(req.params.id));
    } catch (error) {
      res.json({ message: error });
    }
  }
);

cRequests.delete(
  "/api/v1/requests/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const removedRequests = await collectRequest.deleteOne({
        _id: req.params.id,
      });
      res.send(removedRequests);
    } catch (error) {
      res.json({ message: error });
    }
  }
);

export default cRequests;
