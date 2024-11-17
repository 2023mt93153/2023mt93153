import React from 'react';
import { useNavigate } from 'react-router-dom';
import './Dashboard.css'; // Add styles for the dashboard
import { FaLanguage } from 'react-icons/fa';

const Dashboard = ({ user, setSelectedLanguage, setUser }) => {
  const navigate = useNavigate();

  const handleLanguageSelection = (language) => {
    setSelectedLanguage(language); // Update the selected language state
    navigate('/materials'); // Redirect to materials page
  };

  const handleLogout = () => {
    setUser(null); // Clear user data
    navigate('/login'); // Redirect to login page
  };

  return (
    <div className="dashboard-container">
      <h2><FaLanguage /> Welcome, {user?.email || 'User'}!</h2>
      <p>Select a language to start learning:</p>

      <div className="language-selection-buttons">
        <button onClick={() => handleLanguageSelection('English')} className="btn-language">
          English
        </button>
        <button onClick={() => handleLanguageSelection('Spanish')} className="btn-language">
          Spanish
        </button>
        <button onClick={() => handleLanguageSelection('French')} className="btn-language">
          French
        </button>
      </div>

      <p>You can explore our learning materials tailored to your language choice.</p>

      {/* Logout Button */}
      <button onClick={handleLogout} className="btn-logout">
        Logout
      </button>
    </div>
  );
};

export default Dashboard;
