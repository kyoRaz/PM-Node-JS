const type = require('../models/taskType.js');

class TaskTypeService {

    async getList() {
        let types;
        try {
            types = await type.findAll();
        } catch (error) {
            throw error;
        }
        return types
    }


}
module.exports = new TaskTypeService(); 