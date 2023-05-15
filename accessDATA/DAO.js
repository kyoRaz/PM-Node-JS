const pgp = require('pg-promise')();


const db = pgp({
    user: 'postgres',
    password: 'root',
    host: 'localhost',
    port: 5432,
    database: 'task',
    query: (e) => {
        e.client_encoding = 'UTF8';
    }
});
class DAO {


    //USER
    async insertUser(data) {

        const query = 'INSERT INTO utilisateur(nom,prenom,email,numero,password,status) VALUES(${nom},${prenom},${email},${numero},${password},${status})';
        db.none(query, data)
            .then(() => {
                console.log('Data inserted successfully!');
            })
            .catch((error) => {
                console.log('Error:', error);
                throw error;
            });
    }


    async findUserByEmail(email) {
        let myUser;
        let data = { email: email }

        let query = "SELECT * FROM utilisateur WHERE email = ${email}";
        try {
            myUser = await db.oneOrNone(query, data);

        } catch (error) {
            console.log(error);
            throw error;
        }
        return myUser;
    }

    async getUsers() {
        let result;
        try {
            result = await db.many('SELECT * from Utilisateur');
            console.log(result);
        } catch (error) {
            console.error(error);
            throw error;
        }
        return result;
    }

    async getUserById(id) {
        let myUser;
        let data = { id }

        let query = "SELECT * FROM utilisateur WHERE id = ${id}";
        try {
            myUser = await db.oneOrNone(query, data);
        } catch (error) {
            throw error;
        }
        return myUser;
    }

    async getInactivateUsers() {
        let result;
        const status = 'Désactivé';

        let query = "SELECT * from Utilisateur WHERE status='Désactivé' ";
        try {
            result = await db.any(query);
            console.log(result);
        } catch (error) {
            throw error;
        }
        return result;
    }


    async activateUser(id) {
        let data = {
            id: id,
            status: 'Activé'
        };
        const query = 'UPDATE utilisateur Set status=${status} where id=${id}';
        db.none(query, data)
            .then(() => {
                console.log('Data updated successfully!');
            })
            .catch((error) => {
                throw error;
            });
    }


    async deleteBook(id) {
        let data = { id }
        let query = "DELETE  FROM livre WHERE id = ${id}";
        try {
            await db.none(query, data);
            console.log("Élement Supprimer");
        } catch (error) {
            throw error;
        }
    }





}
module.exports = new DAO(); 