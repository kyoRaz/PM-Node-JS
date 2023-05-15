var express = require('express');
const Sequelize = require('sequelize');
const router = express.Router();
var taskType = require('../service/taskTypeService');

router.get('/',
    async (req, res) => {
        try {
            let list = await taskType.getList();
            res.status(200).json({ list });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: 'Server error' });
        }
    }
).get('/:id',
    async (req, res) => {
        // let book = await dao.getBooksById(req.params.id);
        // res.json(book);
    })
    .delete('/:id',
        async (req, res) => {
            // await dao.deleteBook(req.params.id);
            // res.json({ message: 'l \'élément a bien été supprimer' });
        });


module.exports = router;