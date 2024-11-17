const express = require('express');
const router = express.Router();
const { getMaterialsByLanguage } = require('../controllers/materialsController');

// Route to fetch materials filtered by language
router.get('/', getMaterialsByLanguage);

module.exports = router;
