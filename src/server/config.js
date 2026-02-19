import express from "express";
import cors from "cors";
import morgan from "morgan";
import { dirname } from "path";
import { fileURLToPath } from "url";
import { time } from "console";

export default class Server {
  constructor() {
    this.app = express();
    this.port = process.env.PORT || 3001;
    this.middleware();
  }
  middleware() {
    this.app.use(cors());
    this.app.use(express.json());
    this.app.use(morgan("dev"));
    //Configuracion de archivo estatico
    const __dirname = dirname(fileURLToPath(import.meta.url));
    console.log(__dirname);
    console.log(__dirname + "/../..public");
    this.app.use(express.static(__dirname + "/../../public"));
  }
  listen() {
    this.app.listen(this.port, () => {
      console.info(
        `El servidor se esta ejecutando en http://localhost:${this.port}`,
      );
    });
  }
}
