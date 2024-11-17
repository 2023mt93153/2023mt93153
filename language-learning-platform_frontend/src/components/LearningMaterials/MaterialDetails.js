import React from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import './MaterialDetails.css';

const MaterialDetails = ({ materials }) => {
  const { id } = useParams(); // Get the material ID from the URL
  const navigate = useNavigate();

  // Find the material by ID
  const material = materials.find((item) => item.id.toString() === id);

  if (!material) {
    return <p>Material not found. Please go back and try again.</p>;
  }

  return (
    <div className="material-details-container">
      <h2>{material.title}</h2>
      <p><strong>Description:</strong> {material.description}</p>
      <p><strong>Category:</strong> {material.category}</p>
      <p><strong>Level:</strong> {material.level}</p>
      {material.category === 'Audio Exercises' && (
        <div>
          <strong>Audio Exercise:</strong>
          <audio controls>
            <source src={material.link} type="audio/mpeg" />
            Your browser does not support the audio element.
          </audio>
        </div>
      )}
      {material.category !== 'Audio Exercises' && (
        <a
          href={material.link}
          target="_blank"
          rel="noopener noreferrer"
          className="details-link"
        >
          Open Resource
        </a>
      )}
      <button onClick={() => navigate(-1)} className="back-btn">Go Back</button>
    </div>
  );
};

export default MaterialDetails;
