
const Task = require('./Task');
const TaskType = require('./TaskType');
const Utilisateur = require('./Utilisateur');

Task.belongsTo(TaskType, { foreignKey: 'idtype', targetKey: 'id' });
TaskType.hasMany(Task, { foreignKey: 'idtype' });

Task.belongsTo(Utilisateur, { foreignKey: 'idutilisateur', targetKey: 'id' });
Utilisateur.hasMany(Task, { foreignKey: 'idutilisateur' });