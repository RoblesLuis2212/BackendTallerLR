import { Router } from "express";
import routerProductos from "./productos.routes.js";

const router = Router();
router.use("/productos", routerProductos);

export default router;
