import express, { Router } from "express";
// import prisma.request from "../models/request";
import { requestRule, requestRuleNotR } from "../validation/requests";
const { validationResult, param } = require("express-validator");
import { PrismaClient } from "@prisma/client";
import multer from "multer"
import fs from "fs"
import path from "path"

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

    res.status(200).json(savedRequest);
  } catch (error) {
    res.status(400).json({ message: error });
  }
});

cRequests.get("/api/v1/requests/user/:uid", async (req, res) => {
  try {
    const requests = await prisma.request.findMany({
      where: { userId: Number(req.params.uid) },
    });
    res.status(200).json(requests)

  } catch (error) {
    console.log(error);
    res.status(400).json({ message: error });
  }
});

cRequests.get("/api/v1/requests/one/:id", async (req, res) => {
  try {
    const requests = await prisma.request.findMany({
      where: { id: Number(req.params.id) },
    });
    res.status(200).json(requests)
  } catch (error) {
    console.log(error);
    res.status(400).json({ message: error });
  }
});

cRequests.get("/api/v1/requests/done", async (req, res) => {
  try {
    const requests = await prisma.request.findMany({
      where: { stat: Boolean(true) },
    });
    if(requests.length !== 0) return ;
    
    res.status(200).json(requests)

  } catch (error) {
    res.status(400).json({ message: error });
  }
});

cRequests.get("/api/v1/requests/pending", async (req, res) => {
  try {
    const requests = await prisma.request.findMany({
      where: { stat: Boolean(false) },
    });
    res.status(200).json(requests)

  } catch (error) {
    res.status(400).json({ message: error });
  }
});

cRequests.get("/api/v1/requests/done/:id", async (req, res) => {
  try {
    const requests = await prisma.request.findMany({
      where: { user: req.params.id, stat: Boolean(true) },
    });
    res.status(200).json(requests)

  } catch (error) {
    res.status(400).json({ message: error });
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
    res.status(200).json(requests)

  } catch (error) {
    res.status(400).json({ message: error });
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
      res.status(200).json(requests)

    } catch (error) {
      const errors = validationResult(req);

      res.status(400).json({ message: error });
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

      res.status(200).json(
        await prisma.request.findMany({
          where: { id },
        })
      );
    } catch (error) {
      console.log(error);
      res.status(400).json({ message: error });
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
      res.status(200).json(removedRequests)
    } catch (error) {
      console.log(error);
      res.status(400).json({ message: "Invalid Id" });
    }
  }
);



const maxSize = 2 * 1024 * 1024;
const storage = multer.diskStorage({
  destination: './uploads',
  filename: (req, file, cb) => {
    const img = Date.now()+'.jpg'
    cb(null, img);
  }
});

const upload = multer({ storage,limits: { fileSize: maxSize } });

// Define the upload route
cRequests.post('/upload', upload.single('image'), (req, res) => {
  // Get the uploaded file
  const file = req.file;

  // If no file was uploaded, return an error
  if (!file) {
    res.status(400).send('No file was uploaded.');
    return;
  }

  // Create a URL for the file
  const fileUrl = `http://localhost:8000/uploads/${file.filename}`;

  // Send the file URL back to the client
  res.status(200).json({ fileUrl });
});

cRequests.get('/uploads/:filename', (req, res) => {
  // Get the file name
  const filename = req.params.filename;

  // Get the file path
  const filePath = `/uploads/${filename}`;
  const projectPath = path.join(__dirname,  '..', '..',filePath);

  // Check if the file exists
  if (!fs.existsSync(projectPath)) {
    res.status(404).send('File not found.');
    return;
  }

  // Serve the file
  res.sendFile(projectPath);
});


export default cRequests;
