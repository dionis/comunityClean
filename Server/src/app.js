const express = require('express')
import indexRoutes from "./routes/index.routes";
const morgan = require("morgan")
const app = express();
const compression = require("compression")
const cors = require("cors")

app.use(cors({
    origin:'*',
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    preflightContinue: false,
    optionsSuccessStatus: 204,
    'Access-Control-Allow-Origin':'*'
}))

app.use(indexRoutes);
app.use(morgan("dev"));
app.use(compression())
app.use(express.urlencoded({ extended: false }));

export default app;
