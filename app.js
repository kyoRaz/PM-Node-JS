var express = require('express');
var app = express();
const cors = require('cors');
const bodyParser = require("body-parser");
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// Importation des associations entre les modèles
require('./models/associations');

//morgan
const morgan = require('morgan');
app.use(morgan('dev'));

// importation des routes 
const usersRouter = require("./routes/user");
const loginRouter = require("./routes/login");
const taskTypeRouter = require("./routes/taskType");
const taskRouter = require("./routes/task");


//Routage//
app.use("/api/users", usersRouter);
app.use("/api/auth", loginRouter);
app.use("/api/taskType", taskTypeRouter);
app.use("/api/task", taskRouter);





// GESTION DES ERREUR 404 // ze code de routage eo ambony daoly
var notFound = (req, res, next) => {
    res.setHeader('Content-Type', 'text/plain');
    res.send(404, 'Page introuvable !');
}
app.use(notFound);


app.listen(3000,
    () => {
        console.log("Démarrage du serveur");
    }
);