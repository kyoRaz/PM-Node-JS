var express = require('express');
const router = express.Router();
const Sequelize = require('sequelize');
const taskService = require('../service/taskService');

router.get('/',
    async (req, res) => {
        try {
            let task = await taskService.getList();
            res.status(200).json(
                {
                    data: task
                }
            );
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: 'Server error' });
        }
    })

router.get('/details',
    async (req, res) => {
        try {
            let task = await taskService.getDetailsTask();
            res.status(200).json(
                {
                    data: task
                }
            );
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: 'Server error' });
        }
    })

module.exports = router;