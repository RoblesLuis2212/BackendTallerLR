import { Router } from "express";
import { agregarProducto } from "../controllers/productos.controllers.js";

const router = Router();
router.route("/").get(agregarProducto);

export default router;
