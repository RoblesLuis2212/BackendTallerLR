import { json } from "express";
import { prisma } from "../server/prisma.js";

export const agregarProducto = async (req, res) => {
  try {
    const nuevoProducto = await prisma.producto.create({
      data: req.body,
    });
    res.status(201).json({
      mensaje: "Producto agregado exitosamente",
      producto: nuevoProducto,
    });
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ mensaje: "Ocurrio un error al agregar el producto" });
  }
};

export const listarProductos = async (req, res) => {
  try {
    const productos = await prisma.producto.findMany();

    if (productos.length === 0) {
      return res.status(404).json({ mensaje: "No hay productos disponibles" });
    }

    res.status(200).json(productos);
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ mensaje: "Ocurrio un error al listar los productos" });
  }
};

export const eliminarProducto = async (req, res) => {
  try {
    const { id } = req.params;

    const producto = await prisma.producto.delete({
      where: {
        id_producto: Number(id),
      },
    });

    res.status(200).json({ mensaje: "Producto eliminado correctamente" });
  } catch (err) {
    if (err.code === "P2025") {
      return res.status(404).json({ mensaje: "El producto no existe" });
    }
    console.error(err);
    res
      .status(500)
      .json({ mensaje: "Ocurrio un error al eliminar el producto" });
  }
};
