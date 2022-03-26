import express from "express";
const router = express.Router();

import apps from "./user/apps";

router.use("/apps", apps);

export default router;
