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
    await prisma.producto.delete({
      where: {
        id_producto: Number(req.params.id),
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

export const obtenerProductoID = async (req, res) => {
  try {
    const producto = await prisma.producto.findUnique({
      where: {
        id_producto: Number(req.params.id),
      },
    });

    res.status(200).json(producto);
  } catch (err) {
    if (err.code === "P2025") {
      return res.status({ mensaje: "El producto no existe" });
    }
    console.error(err);
    res
      .status(500)
      .json({ mensaje: "Ocurrio un error al obtener el producto" });
  }
};

export const editarProducto = async (req, res) => {
  try {
    await prisma.producto.update({
      where: {
        id_producto: Number(req.params.id),
      },
      data: req.body,
    });

    res.status(200).json({ mensaje: "Producto actualizado correctamente" });
  } catch (err) {
    if (err.code === "P2025") {
      return res.status(404).json({ mensaje: "El producto no existe" });
    }
    console.error(err);
    res.status(500).json({ mensaje: "Ocurrio un error al editar el producto" });
  }
};

export const filtrarProductoNombre = async (req, res) => {
  try {
    const { nombre } = req.query;

    const productos = await prisma.producto.findMany({
      where: {
        nombre: {
          contains: nombre,
          mode: "insensitive",
        },
      },
    });
    res.status(200).json(productos);
  } catch (err) {
    console.error(err);
    res.status(500).json({ mensaje: "Ocurrio un error al filtrar productos" });
  }
};
