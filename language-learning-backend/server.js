const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const materialsRoutes = require('./routes/materials');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors({
    origin: 'http://localhost:3000', // Adjust this to match your frontend URL
  }));
app.use(bodyParser.json());

// Routes
app.use('/api/materials', materialsRoutes);

// Root endpoint
app.get('/', (req, res) => {
  res.send('Language Learning Backend is running!');
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
