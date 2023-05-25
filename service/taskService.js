const Task = require('../models/task.js');
const TaskType = require('../models/taskType.js');
const Utilisateur = require('../models/utilisateur.js');
const DetailsTask = require('../models/detailsTask.js');


class TaskService {

    async getList() {
        let tasks;
        try {
            tasks = await Task.findAll(
                {
                    include: [
                        {
                            model: TaskType
                        },
                        {
                            model: Utilisateur
                        }
                    ]
                }
            );
        } catch (error) {
            throw error;
        }
        return tasks;
    }

    async getDetailsTask() {
        try {
            return await DetailsTask.findAll();
        } catch (error) {
            throw error;
        }
    }


}
module.exports = new TaskService(); 