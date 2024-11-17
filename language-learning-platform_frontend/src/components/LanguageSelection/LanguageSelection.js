import React from 'react';
import { useNavigate } from 'react-router-dom';
import './LanguageSelection.css';

const LanguageSelection = ({ setSelectedLanguage }) => {
  const navigate = useNavigate();

  const handleLanguageSelect = (language) => {
    setSelectedLanguage(language); 
    navigate('/materials'); // Redirect to materials page
  };

  return (
    <div className="language-selection-container">
      <h2>Select a Language</h2>
      <button onClick={() => handleLanguageSelect('English')}>English</button>
      <button onClick={() => handleLanguageSelect('Spanish')}>Spanish</button>
      <button onClick={() => handleLanguageSelect('French')}>French</button>
    </div>
  );
};

export default LanguageSelection;
