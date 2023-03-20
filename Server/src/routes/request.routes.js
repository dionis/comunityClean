import express, { Router } from "express";
// import prisma.request from "../models/request";
import { requestRule, requestRuleNotR } from "../validation/requests";
const { validationResult, param } = require("express-validator");
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();
const cRequests = Router();
cRequests.use(express.json());

cRequests.post("/api/v1/requests", requestRule, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { userId, amountGarbage, stat, image_url, locations } = req.body;

    const savedRequest = await prisma.request.create({
      data: {
        userId,
        amountGarbage,
        stat,
        image_url,
        locations,
      },
    });

    res.send(savedRequest);
  } catch (error) {
    res.json({ message: error });
  }
});

cRequests.get("/api/v1/requests/:id", async (req, res) => {
  try {
    const requests = await prisma.request.findMany({
      where: { id: Number(req.params.id) },
    });
    res.json(requests);
  } catch (error) {
    console.log(error);
    res.json({ message: error });
  }
});

cRequests.get("/api/v1/requests/done", async (req, res) => {
  try {
    const requests = await prisma.request.findMany({
      where: { stat: Boolean(true) },
    });
    res.send(requests);
  } catch (error) {
    res.json({ message: error });
  }
});

cRequests.get("/api/v1/requests/pending", async (req, res) => {
  try {
    const requests = await prisma.request.findMany({
      where: { stat: Boolean(false) },
    });
    res.send(requests);
  } catch (error) {
    res.json({ message: error });
  }
});

cRequests.get("/api/v1/requests/done/:id", async (req, res) => {
  try {
    const requests = await prisma.request.findMany({
      where: { user: req.params.id, stat: Boolean(true) },
    });
    res.send(requests);
  } catch (error) {
    res.json({ message: error });
  }
});

cRequests.get("/api/v1/requests/pending/:id", async (req, res) => {
  try {
    const requests = await prisma.request.findOne({
      where: {
        user: req.params.id,
        stat: false,
      },
    });
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
      const requests = await prisma.request.findOne({
        where: { id: req.params.id },
      });
      res.send(requests);
    } catch (error) {
      const errors = validationResult(req);

      res.json({ message: error });
    }
  }
);

cRequests.put(
  "/api/v1/requests/:id",
  [param("id", "El id debe ser un string").exists().isNumeric()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const id = parseInt(req.params.id);
      const { amountGarbage, stat, image_url, locations } = req.body;
      if (amountGarbage !== undefined) {
        await prisma.request.update({
          where: { id },
          data: { amountGarbage: amountGarbage },
        });
      }
      if (stat !== undefined) {
        await prisma.request.update({
          where: { id },
          data: { stat: stat },
        });
      }
      if (image_url !== undefined) {
        await prisma.request.update({
          where: { id },
          data: { image_url: image_url },
        });
      }
      if (locations !== undefined) {
        await prisma.request.update({
          where: { id },
          data: { locations: locations },
        });
      }

      res.send(
        await prisma.request.findMany({
          where: { id },
        })
      );
    } catch (error) {
      console.log(error);
      res.json({ message: error });
    }
  }
);

cRequests.delete(
  "/api/v1/requests/:id",
  [param("id", "El id debe ser un string").exists().isNumeric()],
  async (req, res) => {
    try {
      const id = parseInt(req.params.id)
      const removedRequests = await prisma.request.delete({
        where: {id}
      });
      res.send(removedRequests);
    } catch (error) {
      console.log(error);
      res.send({ message: "Invalid Id" });
    }
  }
);

export default cRequests;
