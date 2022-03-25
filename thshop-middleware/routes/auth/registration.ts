import express from "express";
const router = express.Router();

import crypto from "crypto-js";

import { executeQuery } from "../../scripts/database";
import { generateSalt } from "../../scripts/authentication";

router.post("/", async (req, res) => {
  try {
    if (!req.body || !req.body.password || !req.body.username)
      throw new Error("Missing username or password!");

    if (req.body.username.length <= 4)
      throw new Error("Username must be at least 5 characters long!");

    if (req.body.password.length <= 7)
      throw new Error("Password must be at least 8 characters long!");

    // check if user already exists
    const usernameData = await executeQuery(
      "select username from thshop.users where username = ?",
      req.body.username
    );

    if (usernameData.length !== 0) throw new Error("Username already taken!");

    // generate password hash => sha256(password + salt)
    const salt = generateSalt();
    const hash = crypto.enc.Base64.stringify(
      crypto.SHA256(req.body.password + salt)
    );

    // create new activated user
    await executeQuery(
      "insert into thshop.users (active, username, passwordhash, passwordsalt, created) values (?, ?, ?, ?, now())",
      [1, req.body.username, hash, salt]
    );

    res.status(200).json({
      status: "success",
      message: "Created user " + req.body.username,
    });
  } catch (error) {
    console.log(error);
    res.status(400).json({
      status: "error",
      message: "Failed to register user " + req.body.username,
    });
  }
});

export default router;
