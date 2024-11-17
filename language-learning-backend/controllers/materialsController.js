const materials = require('../data/materials.json');

const getMaterialsByLanguage = (req, res) => {
  const { language } = req.query;

  if (!language) {
    return res.status(400).json({ message: "Language query parameter is required" });
  }

  const filteredMaterials = materials.filter(
    (material) => material.language.toLowerCase() === language.toLowerCase()
  );

  if (filteredMaterials.length === 0) {
    return res.status(404).json({ message: `No materials found for language: ${language}` });
  }

  res.status(200).json(filteredMaterials);
};

module.exports = { getMaterialsByLanguage };
