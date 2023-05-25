
var dao = require('../accessDATA/DAO');
const user = require('../models/utilisateur.js');
const bcrypt = require('bcrypt');

class UserService {



    async confirmPWD(password, confirmPWD) {
        try {

            if (password != null && confirmPWD != null && password === confirmPWD) {
                if (password.length >= 8) {
                    // Hash the password
                    const hashedPassword = await bcrypt.hash(password, 10);
                    return hashedPassword;
                } else {
                    throw new Error("le mot de passe est trop court");
                }
            } else {
                throw new Error("les mots de passe ne correspendent pas");
            }

        } catch (e) {
            throw e;
        }

    }


    async insertUser(nom, prenom, email, numero, mdp) {
        const user = {
            nom: nom,
            prenom: prenom,
            email: email,
            numero: numero,
            password: mdp,
            status: 'Désactivé'
        };

        try {
            dao.insertUser(user);
        }
        catch (e) {
            throw e;
        }
    }

    async findUserByEmail(email) {
        try {
            return dao.findUserByEmail(email);
        } catch (e) {
            throw e;
        }
    }


    async getUsers() {
        let users;
        try {
            users = await user.findAll({
                where: {
                    status: 'Activé'
                }
            });

        } catch (e) {
            throw e;
        }
        return users;
    }

    async getUserById(id) {
        let myUser;
        try {
            myUser = user.findOne({
                where: {
                    id: id
                }
            });
        } catch (error) {
            throw error;
        }
        return myUser;
    }

    async getInactivateUsers() {
        let users;
        try {
            users = user.findAll(
                {
                    where: {
                        status: 'Désactivé'
                    }
                });
            console.log(users);

        } catch (e) {
            throw e;
        }
        return users;
    }

    async activateUser(id) {
        try {
            await dao.activateUser(id);
        } catch (e) {
            throw e;
        }
    }

    async deleteInactivateUser(id) {
        try {
            await user.destroy({
                where: {
                    id: id,
                    status: 'Désactivé'
                }
            }
            );
        } catch (error) {
            throw error;
        }
    }

    async deleteUser(id) {
        try {
            await user.destroy({
                where: {
                    id: id,
                }
            }
            );
        } catch (error) {
            throw error;
        }
    }


    async updateNomUser(id, nom) {
        await user.update({ nom: nom }, { where: { id: id } })
            .then(() => {
                console.log('Update successful');
            })
            .catch((err) => {
                console.error(err);
                throw err;
            });
    }


    async getListUsers(condition) {

        let list;
        try {
            list = await user.findAll(condition);
        } catch (error) {
            throw error;

        }
        return list;
    }

    async count(where) {
        let value;
        try {
            value = await user.count({ where });
        } catch (error) {
            throw error;
        }
        return value;
    }

    async updateUser(updatedUser) {
        let id = updatedUser.id;
        updatedUser = this.createDoubleNonNull(updatedUser);
        user.update(updatedUser, { where: { id: id } })
            .then(() => {
                console.log('Mise à jour réussie');
            })
            .catch((error) => {
                throw error;
            });

    }

    createDoubleNonNull(monObjet) {
        // Récupérer les entrées non-nulles de l'objet original
        const entreesNonNulles = Object.entries(monObjet).filter(([_, valeur]) => valeur !== null);
        // Créer un nouvel objet avec les entrées non-nulles
        const nouvelObjet = Object.fromEntries(entreesNonNulles);
        delete nouvelObjet.id;
        return nouvelObjet;
    }


}
module.exports = new UserService(); 