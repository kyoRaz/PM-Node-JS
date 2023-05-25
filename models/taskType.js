const Sequelize = require('sequelize');
const sequelize = require('../accessDATA/sequelize.js');

const TaskType = sequelize.define('TaskType', {
    // Définissez les attributs de votre modèle ici
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    nom: {
        type: Sequelize.STRING,
        allowNull: false
    }
}, {
    tableName: 'tasktype',
    timestamps: false
}
);

module.exports = TaskType;