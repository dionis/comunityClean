const express = require('express')
import indexRoutes from "./routes/index.routes";
const morgan = require("morgan")
const app = express();
const compression = require("compression")

app.use(indexRoutes);
app.use(morgan("dev"));
app.use(compression())
app.use(express.urlencoded({ extended: false }));

export default app;
