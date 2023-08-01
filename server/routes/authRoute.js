import express from "express";
import { login, logout, register, updateProfile } from "../controller/auth.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/logout", logout);
router.post("/update-profile", authMiddleware, updateProfile);

export default router;
