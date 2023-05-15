var express = require('express');
var userService = require('../service/userService');
const Sequelize = require('sequelize');
const router = express.Router();

// const cors = require('cors');
const jwt = require('jsonwebtoken');

router.post('/',
    async (req, res) => {

        const { nom, prenom, email, numero, password, confirmPWD } = req.body;
        try {
            // Check if the user already exists
            const existingUser = await userService.findUserByEmail(email);
            if (existingUser) {
                res.status(409).json({ message: 'Email already in use' });
            } else {

                let hashedPassword = await userService.confirmPWD(password, confirmPWD);
                // Create a new user
                userService.insertUser(nom, prenom, email, numero, hashedPassword);
                res.status(201).json({ message: 'Data inserted successfully!' });
            }
        } catch (error) {
            console.log("ERREUR 500");
            res.status(500).json({ message: error.message });
        }

    });


// Route pour récupérer tous les produits en utilisant des filtres et la pagination
router.get('/inactivate',
    async (req, res) => {
        const limit = parseInt(req.query.limit) || 10; // Nombre d'éléments à retourner (par défaut 10)
        const page = parseInt(req.query.page) || 1; // Numéro de page (par défaut 1)
        const offset = limit * (page - 1); // Offset à utiliser pour la pagination
        const where = {
            status: 'Désactivé'
        }; // Filtres pour la requête Sequelize
        if (req.query.nom) {
            where.prenom = {
                [Sequelize.Op.like]: `%${req.query.nom}%`
            };
        }
        try {
            let count = await userService.count(where);
            let condition = {
                where,
                limit,
                offset
            }
            const list = await userService.getListUsers(condition);
            res.json({
                list,
                count
            });
        } catch (error) {
            console.error(error);
            res.status(500).json({ error: 'Erreur lors de la récupération des données' });
        }

    });


//Liste utilisateur
router.get('/',
    async (req, res) => {
        const limit = parseInt(req.query.limit) || 10;
        const page = parseInt(req.query.page) || 1;
        const offset = limit * (page - 1);
        let where = {
            status: 'Activé',
        }
        if (req.query.nom) {
            where[Sequelize.Op.or] = [
                { prenom: { [Sequelize.Op.like]: `%${req.query.nom}%` } },
                { nom: { [Sequelize.Op.like]: `%${req.query.nom}%` } }
            ];
        }
        try {
            let count = await userService.count(where);
            let condition = {
                where,
                limit,
                offset,
                order: [['id', 'ASC']]
            }
            let users = await userService.getListUsers(condition);
            // let users = await userService.getUsers();
            res.status(200).json({ users, count });
        } catch (error) {
            console.log(error.message);
            res.status(500).json({ message: 'Server error' });
        }
    }).get('/:id',
        async (req, res) => {
            try {
                let user = await userService.getUserById(req.params.id);
                res.status(200).json(user);
            } catch (error) {
                console.log(error.message);
                res.status(500).json({ message: 'Server error' });
            }
        }).put('/:id',
            (req, res) => {
                try {
                    let id = req.params.id;
                    const updatedUser = req.body.user;
                    userService.updateUser(updatedUser);
                    res.status(200).json({ message: "mis à jour effectuer" });
                } catch (error) {
                    console.log(error.message);
                    res.status(500).json({ message: 'Server error' });
                }
            }
        ).delete('/:id',
            async (req, res) => {
                try {
                    let id = req.params.id;
                    await userService.deleteUser(id);
                    res.status(200).json({ message: "l'utilisateur a bien été supprimer" });
                } catch (error) {
                    console.log(error);
                    res.status(500).json({ message: 'Server error' });
                }
            });

//Approuver nouvel utilisateur 
router.put('/activate/:id',
    async (req, res) => {
        try {
            let id = req.params.id;
            userService.activateUser(id);
            res.status(200).json({ message: "Nouvel utilisateur ajouté" });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: 'Server error' });
        }
    });

router.delete('/inactivate/:id',
    (req, res) => {
        try {
            let id = req.params.id;
            userService.deleteInactivateUser(id);
            res.status(200).json({ message: "l'utilisateur a bien été supprimer" });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: 'Server error' });
        }
    });

// Test Update
router.put('/:id',
    (req, res) => {
        try {
            let id = req.params.id;
            let nom = req.body.nom;
            userService.updateUser(id, nom);
            res.status(200).json({ message: "l'utilisateur a bien été supprimer" });
        } catch (error) {
            console.log(error);
            res.status(500).json({ message: 'Server error' });
        }
    });




module.exports = router;