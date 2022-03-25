import jwt from "jsonwebtoken";

function verifyToken(req: any, res: any, next: any) {
  try {
    const bearerHeader = req.headers.authorization;

    if (typeof bearerHeader !== "undefined") {
      const bearer = bearerHeader.split(" ")[1];
      req.token = bearer;

      // verify jwt and set decoded
      const decoded = jwt.verify(bearer, process.env.JWT_SECRET);
      req.decoded = decoded;

      // forward
      next();
    } else throw new Error("Invalid authorization header");
  } catch (error) {
    res.status(401).json({ status: "error", message: error.toString() });
  }
}

function generateSalt() {
  let result = ""
  const characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  for (let i = 0; i < 16; i++) {
    result += characters.charAt(Math.floor(Math.random() * characters.length))
  }
  return result
}


export { verifyToken, generateSalt }