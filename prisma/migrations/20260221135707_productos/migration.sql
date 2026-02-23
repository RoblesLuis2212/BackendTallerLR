-- CreateEnum
CREATE TYPE "estado" AS ENUM ('DISPONIBLE', 'NO_DISPONIBLE');

-- CreateTable
CREATE TABLE "Producto" (
    "id_producto" SERIAL NOT NULL,
    "codigo_producto" TEXT NOT NULL,
    "stock" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "tipo" TEXT,
    "tamanio" TEXT NOT NULL,
    "descripcion" TEXT,
    "categoria" TEXT,
    "precio_unitario" DECIMAL(65,30) NOT NULL,
    "estado" "estado" NOT NULL DEFAULT 'DISPONIBLE',

    CONSTRAINT "Producto_pkey" PRIMARY KEY ("id_producto")
);
