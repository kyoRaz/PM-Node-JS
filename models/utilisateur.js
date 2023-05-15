const Sequelize = require('sequelize');
const sequelize = require('../accessDATA/sequelize.js');

const Utilisateur = sequelize.define('utilisateur', {
    // Définissez les attributs de votre modèle ici
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    nom: {
        type: Sequelize.STRING,
        allowNull: false
    },
    prenom: {
        type: Sequelize.STRING,
        allowNull: false
    },
    cin: {
        type: Sequelize.STRING,
        allowNull: false
    },
    email: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true
    },
    numero: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true
    },
    sexe: {
        type: Sequelize.ENUM('Homme', 'Femme'),
        allowNull: false
    },
    status: {
        type: Sequelize.STRING,
        allowNull: false
    },
    password: {
        type: Sequelize.STRING,
        allowNull: false
    }
}, {
    tableName: 'utilisateur',
    timestamps: false
}
);

module.exports = Utilisateur;