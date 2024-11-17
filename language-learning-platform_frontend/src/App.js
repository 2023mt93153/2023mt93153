import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Login from './components/Auth/Login';
import Register from './components/Auth/Register';
import LanguageSelection from './components/LanguageSelection/LanguageSelection';
import Materials from './components/LearningMaterials/Materials';
import MaterialDetails from './components/LearningMaterials/MaterialDetails';
import Dashboard from './components/Dashboard/Dashboard'; // Import Dashboard
import './styles/App.css';

function App() {
  const [selectedLanguage, setSelectedLanguage] = useState(''); // Language state
  const [user, setUser] = useState(null); // User data state

  // Sample materials data
  const sampleMaterials = [
    {
      id: 1,
      title: 'Basic Grammar Lessons',
      description: 'Learn the foundational grammar rules for Spanish.',
      category: 'Grammar',
      language: 'Spanish',
      level: 'Beginner',
      link: 'https://example.com/spanish-grammar',
    },
    {
      id: 2,
      title: 'Advanced Vocabulary',
      description: 'Expand your vocabulary for professional communication.',
      category: 'Vocabulary',
      language: 'English',
      level: 'Advanced',
      link: 'https://example.com/vocabulary',
    },
    {
      id: 3,
      title: 'Pronunciation Practice',
      description: 'Audio exercises for mastering French pronunciation.',
      category: 'Audio Exercises',
      language: 'French',
      level: 'Intermediate',
      link: 'https://example.com/pronunciation',
    },
  ];

  return (
    <Router>
      <header className="app-header">
        <h1>LangLearn</h1>
      </header>
      <Routes>
        {/* Login and Register Routes */}
        <Route
          path="/login"
          element={<Login setUser={setUser} />}
        />
        <Route
          path="/register"
          element={<Register setUser={setUser} />}
        />

        {/* Dashboard Route */}
        <Route
          path="/dashboard"
          element={
            <Dashboard 
              user={user} 
              setSelectedLanguage={setSelectedLanguage} 
              setUser={setUser} // Pass setUser here
            />
          }
        />

        {/* Language Selection */}
        <Route
          path="/select-language"
          element={<LanguageSelection setSelectedLanguage={setSelectedLanguage} />}
        />

        {/* Learning Materials */}
        <Route
          path="/materials"
          element={
            <Materials
              selectedLanguage={selectedLanguage}
              materials={sampleMaterials}
            />
          }
        />

        {/* Material Details */}
        <Route
          path="/materials/:id"
          element={<MaterialDetails materials={sampleMaterials} />}
        />
      </Routes>
    </Router>
  );
}

export default App;
