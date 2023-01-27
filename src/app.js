const express = require('express')
import indexRoutes from "./routes/index.routes";
const morgan = require("morgan")
const app = express();

app.use(indexRoutes);
app.use(morgan("dev"));
app.use(express.urlencoded({ extended: false }));


export default app;
