-- CreateEnum
CREATE TYPE "tipoAsistencia" AS ENUM ('ENTRADA', 'SALIDA');

-- CreateTable
CREATE TABLE "Asistencia" (
    "id_asistencia" SERIAL NOT NULL,
    "id_Empleado" INTEGER NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tipo" "tipoAsistencia" NOT NULL,

    CONSTRAINT "Asistencia_pkey" PRIMARY KEY ("id_asistencia")
);

-- AddForeignKey
ALTER TABLE "Asistencia" ADD CONSTRAINT "Asistencia_id_Empleado_fkey" FOREIGN KEY ("id_Empleado") REFERENCES "Empleado"("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE;
