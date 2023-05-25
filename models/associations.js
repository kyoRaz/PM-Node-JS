
const Task = require('./task');
const TaskType = require('./taskType');
const Utilisateur = require('./utilisateur');

Task.belongsTo(TaskType, { foreignKey: 'idtype', targetKey: 'id' });
TaskType.hasMany(Task, { foreignKey: 'idtype' });

Task.belongsTo(Utilisateur, { foreignKey: 'idutilisateur', targetKey: 'id' });
Utilisateur.hasMany(Task, { foreignKey: 'idutilisateur' });