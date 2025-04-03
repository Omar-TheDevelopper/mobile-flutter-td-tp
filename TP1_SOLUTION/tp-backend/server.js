const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');

const app = express();
const port = 3000;

// Middleware to parse JSON
app.use(bodyParser.json());

// Load data from data.json
const loadData = () => {
    const data = fs.readFileSync('data.json', 'utf8');
    return JSON.parse(data);
};

// Save data to data.json
const saveData = (data) => {
    fs.writeFileSync('data.json', JSON.stringify(data, null, 2));
};

// Test route
app.get('/', (req, res) => {
    res.send('API Backend is running!');
});

// Start the server
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
app.get('/products', (req, res) => {
    const data = loadData();
    res.json(data.products);
});
app.post('/products', (req, res) => {
    const data = loadData();
    const newProduct = req.body;
    data.products.push(newProduct);
    saveData(data);
    res.status(201).send('Product added');
});
app.get('/orders', (req, res) => {
    const data = loadData();
    res.json(data.orders);
});
app.post('/orders', (req, res) => {
    const data = loadData();
    const newOrder = req.body;
    data.orders.push(newOrder);
    saveData(data);
    res.status(201).send('Order created');
});