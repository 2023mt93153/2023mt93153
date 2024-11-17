import React from 'react';
import './Materials.css';

const Materials = ({ materials, selectedLanguage }) => {
  // Filter materials based on the selected language
  const filteredMaterials = selectedLanguage
    ? materials.filter((material) =>
        material.language.toLowerCase() === selectedLanguage.toLowerCase()
      )
    : materials;

  if (!filteredMaterials || filteredMaterials.length === 0)
    return <p>No materials available for {selectedLanguage || 'the selected language'}.</p>;

  return (
    <div className="materials-container">
      <h2>Learning Materials for {selectedLanguage || 'All Languages'}</h2>
      {filteredMaterials.map((material) => (
        <div key={material.id} className="material-card">
          <h3>{material.title}</h3>
          <p>{material.description}</p>
          <p>Category: {material.category}</p>
          <p>Level: {material.level}</p>
          <a href={material.link} target="_blank" rel="noopener noreferrer">
            Learn More
          </a>
        </div>
      ))}
    </div>
  );
};

export default Materials;
