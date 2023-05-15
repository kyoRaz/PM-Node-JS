const Sequelize = require('sequelize');

const sequelize = new Sequelize('task', 'postgres', 'root', {
    host: 'localhost',
    dialect: 'postgres',
    charset: 'utf8'
});

module.exports = sequelize;
