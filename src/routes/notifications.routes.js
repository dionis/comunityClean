import express, { Router } from "express";
import notification from "../models/notification";
import notificationRule from "../validation/notification";
const { validationResult, param } = require("express-validator");

const notifications = Router();
notifications.use(express.json());

notifications.post(
  "/api/v1/notifications",
  notificationRule,
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const notif = notification(req.body);
      const notifSaved = await notif.save();

      res.send(notifSaved);
    } catch (error) {
      console.log(error);
      res.json({ message: error });
    }
  }
);

notifications.get("/api/v1/notifications", async (req, res) => {
  try {
    const notif = await notification.find();
    res.send(notif);
  } catch (error) {
    res.json({ message: error });
  }
});

notifications.get(
  "/api/v1/notifications/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const notifications = await notification.findById(req.params.id);
      res.send(notifications);
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

notifications.put(
  "/api/v1/notifications/:id",
  [
    param("id", "El id debe ser un string").exists().isString(),
    notificationRule,
  ],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const { message, isSended, isRecived } = req.body;
      if (message !== undefined) {
        await notification.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { message: message }
        );
      }
      if (isSended !== undefined) {
        await notification.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { isSended: isSended }
        );
      }
      if (isRecived !== undefined) {
        await notification.findOneAndUpdate(
          {
            _id: req.params.id,
          },
          { isRecived: isRecived }
        );
      }

      res.send(await notification.findById(req.params.id));
    } catch (error) {
      res.json({ message: error });
    }
  }
);

notifications.delete(
  "/api/v1/notifications/:id",
  [param("id", "El id debe ser un string").exists().isString()],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }
      const removedNotif = await notification.deleteOne({
        _id: req.params.id,
      });
      res.send(removedNotif);
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

export default notifications;
