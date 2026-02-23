import { Router } from "express";
import {
  agregarProducto,
  editarProducto,
  eliminarProducto,
  listarProductos,
  obtenerProductoID,
} from "../controllers/productos.controllers.js";

const router = Router();
router.route("/").get(listarProductos).post(agregarProducto);
router
  .route("/:id")
  .delete(eliminarProducto)
  .get(obtenerProductoID)
  .put(editarProducto);

export default router;
