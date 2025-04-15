
const express = require("express");
const cors = require("cors");
const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const dadosHotel = [];

// POST - add pet
app.post("/pets", (req, res) => {
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

//get - visualiza 
app.get("/pets", (req, res) => {
  if (dadosHotel.length > 0) {
    res.status(200).send({
      status_code: 200,
      pets: dadosHotel,
    });
  } else {
    res.status(200).send({
      status_code: 200,
      pets: [],
    });
  }
});

//delete - apagar
app.post("/pets/:id", (req, res) => {
  let id =req.params.id*1;
  let dadosExcluir = dadosHotel.find(p=>p.id === id);
  let index = dadosHotel.indexOf(dadosExcluir);

  dadosHotel.splice(index,1);

  res.status(204).send({
    'status': 'sucess',
    'message': 'Pet Excluido'
  });
})
// Iniciar o servidor
app.listen(2000, '0.0.0.0', () => {
  console.log("Servidor rodando");
});