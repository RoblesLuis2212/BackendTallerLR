/*
  Warnings:

  - You are about to drop the column `codigo_producto` on the `Producto` table. All the data in the column will be lost.
  - You are about to drop the column `tipo` on the `Producto` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "tipo" AS ENUM ('AUTO', 'MOTO', 'CAMIONETA');

-- CreateEnum
CREATE TYPE "rol" AS ENUM ('ADMIN', 'EMPLEADO');

-- CreateEnum
CREATE TYPE "estadoUsuario" AS ENUM ('ACTIVO', 'INACTIVO', 'SUSPENDIDO');

-- CreateEnum
CREATE TYPE "estadoServicio" AS ENUM ('DISPONIBLE', 'NO_DISPONIBLE');

-- CreateEnum
CREATE TYPE "estadoTurno" AS ENUM ('PENDIENTE', 'COMPLETADO');

-- AlterTable
ALTER TABLE "Producto" DROP COLUMN "codigo_producto",
DROP COLUMN "tipo",
ALTER COLUMN "tamanio" DROP NOT NULL;

-- CreateTable
CREATE TABLE "Cliente" (
    "id_cliente" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "dni" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "fecha_registro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Cliente_pkey" PRIMARY KEY ("id_cliente")
);

-- CreateTable
CREATE TABLE "Vehiculo" (
    "id_vehiculo" SERIAL NOT NULL,
    "marca" TEXT,
    "modelo" TEXT,
    "anio" INTEGER,
    "patente" TEXT NOT NULL,
    "color" TEXT NOT NULL,
    "tipo" "tipo",
    "fechaAlta" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cliente_Id" INTEGER NOT NULL,

    CONSTRAINT "Vehiculo_pkey" PRIMARY KEY ("id_vehiculo")
);

-- CreateTable
CREATE TABLE "Empleado" (
    "id_empleado" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "dni" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "puesto" TEXT NOT NULL,
    "fecha_Registro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "salario" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "Empleado_pkey" PRIMARY KEY ("id_empleado")
);

-- CreateTable
CREATE TABLE "Usuario" (
    "id_usuario" SERIAL NOT NULL,
    "usuario" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "rol" "rol" NOT NULL,
    "estado" "estadoUsuario" NOT NULL DEFAULT 'ACTIVO',
    "id_Empleado" INTEGER NOT NULL,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "servicio" (
    "id_servicio" SERIAL NOT NULL,
    "nombre_servicio" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,
    "precio_estimado" DECIMAL(65,30) NOT NULL,
    "estado_servicio" "estado" NOT NULL DEFAULT 'DISPONIBLE',

    CONSTRAINT "servicio_pkey" PRIMARY KEY ("id_servicio")
);

-- CreateTable
CREATE TABLE "Turno" (
    "id_turno" SERIAL NOT NULL,
    "id_Cliente" INTEGER NOT NULL,
    "id_Empleado" INTEGER,
    "id_Vehiculo" INTEGER NOT NULL,
    "fecha_Turno" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "motivo" TEXT,
    "estado" "estadoTurno" NOT NULL DEFAULT 'PENDIENTE',
    "observaciones" TEXT,

    CONSTRAINT "Turno_pkey" PRIMARY KEY ("id_turno")
);

-- CreateIndex
CREATE UNIQUE INDEX "Cliente_dni_key" ON "Cliente"("dni");

-- CreateIndex
CREATE UNIQUE INDEX "Cliente_email_key" ON "Cliente"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Vehiculo_patente_key" ON "Vehiculo"("patente");

-- CreateIndex
CREATE UNIQUE INDEX "Empleado_dni_key" ON "Empleado"("dni");

-- AddForeignKey
ALTER TABLE "Vehiculo" ADD CONSTRAINT "Vehiculo_cliente_Id_fkey" FOREIGN KEY ("cliente_Id") REFERENCES "Cliente"("id_cliente") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Usuario" ADD CONSTRAINT "Usuario_id_Empleado_fkey" FOREIGN KEY ("id_Empleado") REFERENCES "Empleado"("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Turno" ADD CONSTRAINT "Turno_id_Cliente_fkey" FOREIGN KEY ("id_Cliente") REFERENCES "Cliente"("id_cliente") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Turno" ADD CONSTRAINT "Turno_id_Empleado_fkey" FOREIGN KEY ("id_Empleado") REFERENCES "Empleado"("id_empleado") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Turno" ADD CONSTRAINT "Turno_id_Vehiculo_fkey" FOREIGN KEY ("id_Vehiculo") REFERENCES "Vehiculo"("id_vehiculo") ON DELETE RESTRICT ON UPDATE CASCADE;
