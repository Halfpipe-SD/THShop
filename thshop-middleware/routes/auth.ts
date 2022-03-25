import express from "express";
const router = express.Router();

import login from "./auth/login";
import token from "./auth/token";
import registration from "./auth/registration";

router.use("/login", login);
router.use("/token", token);
router.use("/registration", registration);

export default router;
