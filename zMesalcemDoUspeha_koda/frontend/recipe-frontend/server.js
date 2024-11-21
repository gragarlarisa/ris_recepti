// Uvozi potrebne module
const express = require('express');
const cors = require('cors');
const axios = require('axios');
const path = require('path');

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname))); // Omogoča dostop do statičnih datotek

const PORT = process.env.PORT || 3000;

// GET zahteva za pridobivanje receptov
app.get('/api/recepti', async (req, res) => {
    try {
        const response = await axios.get('http://localhost:8080/api/recepti');
        res.json(response.data);
    } catch (error) {
        res.status(500).send("Napaka pri pridobivanju receptov");
    }
});

// POST zahteva za dodajanje novega recepta
app.post('/api/recepti', async (req, res) => {
    try {
        const recept = req.body; // Pridobi telo zahteve
        const response = await axios.post('http://localhost:8080/api/recepti', recept);
        res.status(201).json(response.data); // Vrni nov dodan recept
    } catch (error) {
        res.status(500).send("Napaka pri dodajanju recepta");
    }
});

// PUT zahteva za posodobitev recepta
app.put('/api/recepti/:id', async (req, res) => {
    try {
        const recept = req.body;
        const id = req.params.id; // Pridobi ID iz poti
        const response = await axios.put(`http://localhost:8080/api/recepti/${id}`, recept);
        res.json(response.data); // Vrni posodobljen recept
    } catch (error) {
        res.status(500).send("Napaka pri posodabljanju recepta");
    }
});

// DELETE zahteva za brisanje recepta
app.delete('/api/recepti/:id', async (req, res) => {
    try {
        const id = req.params.id; // Pridobi ID iz poti
        await axios.delete(`http://localhost:8080/api/recepti/${id}`);
        res.sendStatus(204); // Vrni 204 No Content
    } catch (error) {
        res.status(500).send("Napaka pri brisanju recepta");
    }
});

// Osnovno usmerjanje za prikaz sporočila
app.get('/', (req, res) => {
    res.send('Dobrodošli v aplikaciji za recepte! Uporabite /api/recepti za pridobivanje receptov.');
});

// Ustvarite usmerjanje za neobstoječe poti
app.use((req, res) => {
    res.status(404).send('Stran ne obstaja!');
});

// Zagon strežnika
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
