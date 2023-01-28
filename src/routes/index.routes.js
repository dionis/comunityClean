import express, { Router } from "express";
import notifications from "./notifications.routes";
import cRequests from "./request.routes";
import groups from "./group.routes";
import users from "./user.routes";
import admins from "./admin.routes";

const router = Router();
router.use(cRequests);
router.use(notifications);
router.use(groups);
router.use(users);
router.use(admins);

export default router;
