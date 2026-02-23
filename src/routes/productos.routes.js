import { Router } from "express";
import {
  agregarProducto,
  eliminarProducto,
  listarProductos,
} from "../controllers/productos.controllers.js";

const router = Router();
router.route("/").get(listarProductos).post(agregarProducto);
router.route("/:id").delete(eliminarProducto);

export default router;
