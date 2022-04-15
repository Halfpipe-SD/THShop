import express from "express";
const router = express.Router();

import crypto from "crypto-js";
import jwt from "jsonwebtoken";

import { executeQuery } from "../../scripts/database";

const tokenExpire: string = process.env.TOKEN_EXPIRE;

router.post("/", async (req: any, res: any) => {
  try {
    if (!req.body || !req.body.password || !req.body.username)
      throw new Error("Missing password or username");

    let data = await executeQuery(
      process.env.DB_NAME,
      "select username, passwordsalt from users where username = ?;",
      req.body.username
    );

    if (data.length === 0) throw new Error("User could not be found!");
    if (data.length > 1) throw new Error("Multiple users found!");
    if (!data[0].passwordsalt) throw new Error("Salt could not be found!");

    // generate password hash => sha256(password + salt)
    const hash = crypto.enc.Base64.stringify(
      crypto.SHA256(req.body.password + data[0].passwordsalt)
    );

    // check if user is valid
    data = await executeQuery(
      process.env.DB_NAME,
      "select active, username, passwordhash from users where username = ? and passwordhash = ?;",
      [req.body.username, hash]
    );

    if (data.length === 0) throw new Error("Invalid password!");
    if (data.length > 1) throw new Error("Identical users found!");
    if (data[0].active === 0) throw new Error("Account deactivated!");

    // set users last login date
    await executeQuery(
      process.env.DB_NAME,
      "update users set lastLogin = now() where username = ?;",
      req.body.username
    );

    // // sign userdata token
    const token = jwt.sign(
      { username: req.body.username },
      process.env.JWT_SECRET,
      { expiresIn: tokenExpire }
    );

    res.status(200).json({
      status: "success",
      message: "Signed in as user " + req.body.username,
      token,
    });
  } catch (error) {
    res.status(400).json({ status: "error", message: error.toString() });
  }
});

export default router;
