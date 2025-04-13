const express = require("express");
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const dadosHotel = [];

// Iniciar o servidor
app.listen(2000, () => {
  console.log("Servidor rodando em http://localhost:2000");
});

app.post("/api/add", (req, res) => {
    console.log("Recebido:", req.body);
  
    const novoPet = {
      id: dadosHotel.length + 1,
      tutorNome: req.body.tutorNome,
      tutorContato: req.body.tutorContato,
      especie: req.body.especie,
      raca: req.body.raca,
      dataEntrada: req.body.dataEntrada,
      dataSaida: req.body.dataSaida,
    };
  
    dadosHotel.push(novoPet);
  
    console.log("Atualizado:", dadosHotel);
  
    res.status(200).send({
      status: 200,
      message: "Adicionado com sucesso",
      dados: dadosHotel,
    });
  });
  