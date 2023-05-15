const Sequelize = require('sequelize');
const sequelize = require('../accessDATA/sequelize.js');

const DetailsTask = sequelize.define('detailstask', {
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
    },
    libelle: {
        type: Sequelize.STRING,
        allowNull: false
    },
    idtype: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    type: {
        type: Sequelize.STRING,
        allowNull: false
    },
    idutilisateur: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    auteur: {
        type: Sequelize.STRING,
        allowNull: false
    }

}, {
    tableName: 'detailstask',
    timestamps: false
}
);

module.exports = DetailsTask;