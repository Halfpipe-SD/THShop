import express from "express";
const router = express.Router();

import { verifyToken } from "../../scripts/authentication";

router.get("/", verifyToken, (req: any, res: any) => {
  const apps = [
    {
      title: "Home",
      name: "home",
      icon: "mdi-home",
    },
    {
      title: "Profile",
      name: "profile",
      icon: "mdi-account",
    },
    {
      title: "About",
      name: "about",
      icon: "mdi-information",
    },
  ];

  res.status(200).json({ status: "success", apps });
});

export default router;
