var express = require('express');
var userService = require('../service/userService');
var router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');


//AUTH
router.post('/',
    async (req, res) => {
        const { email, password } = req.body;

        // Find the user by email
        let user = await userService.findUserByEmail(email);

        if (!user) {
            res.status(404).json({ message: 'User not found' });
        } else {
            // Compare the password
            // console.log(user);
            bcrypt.compare(password, user.password, (err, isMatch) => {
                if (err) {
                    res.status(500).json({ message: 'Server error' });
                }

                if (!isMatch) {
                    res.status(401).json({ message: 'Invalid credentials' });
                } else {
                    // Create a JWT
                    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1d' });
                    res.json({
                        token,
                        user: user
                    });
                }


            });
        }
    });

module.exports = router;