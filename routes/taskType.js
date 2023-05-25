var express = require('express');
const Sequelize = require('sequelize');
const router = express.Router();
var taskTypeService = require('../service/taskTypeService');

router.get('/',
    async (req, res) => {
        try {
            let list = await taskTypeService.getList();
            res.status(200).json({ list });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: 'Server error' });
        }
    }
);

module.exports = router;