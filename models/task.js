const Sequelize = require('sequelize');
const sequelize = require('../accessDATA/sequelize.js');

const Task = sequelize.define('task', {
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    libelle: {
        type: Sequelize.STRING,
        allowNull: false
    },
    idtype: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    idutilisateur: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
}, {
    tableName: 'task',
    timestamps: false
}
);

module.exports = Task;