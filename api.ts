import express from "express";

const app = express();
const PORT = 3000;
const objResponse = [{ name: "Murilo", age: 22, city: "São Paulo" }, { name: "João", age: 30, city: "Rio de Janeiro" }, { name: "Maria", age: 25, city: "Belo Horizonte" }];

app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));

app.get('/', (req, res) => {
    res.json(objResponse);
});

app.use(express.json());
