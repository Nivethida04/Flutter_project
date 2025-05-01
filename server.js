const express = require('express');
const mongoose = require('mongoose');
const routes = require('./routes/routes');

const app = express();

app.use(express.json());
app.use('/', routes);

const MONGO_URI = 'mongodb+srv://nivethida04:rwk4dUwmeNfiHrE6@cluster0.qirt3.mongodb.net/CrudAPI?retryWrites=true&w=majority&appName=Cluster0';

mongoose.connect(MONGO_URI)
  .then(() => {
    console.log('MongoDB Connected!');
    app.listen(3000, () => {
      console.log('Server running on port 3000');
    });
  })
  .catch((err) => {
    console.log('Connection failed:', err);
  });

app.get('/', (req, res) => {
  res.send('API is working');
});
