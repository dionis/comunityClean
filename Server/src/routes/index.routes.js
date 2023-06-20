import express, { Router } from "express";
import notifications from "./notifications.routes";
import cRequests from "./request.routes";
import groups from "./group.routes";
import users from "./user.routes";
import admins from "./admin.routes";
import stats from "./stats.routes";
import workers from "./worker.routes";
import payment from './payment.routes';

const router = Router();
router.use(cRequests);
router.use(notifications);
router.use(payment);
router.use(groups);
router.use(users);
router.use(admins);
router.use(stats);
router.use(workers);

export default router;
