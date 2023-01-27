import express, { Router } from "express";
import notifications from "./notifications.routes";
import cRequests from "./request.routes";
import groups from "./group.routes";
import users from "./user.routes";

const router = Router();
router.use(cRequests);
router.use(notifications);
router.use(groups);
router.use(users);

export default router;
