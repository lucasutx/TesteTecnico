import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/hotel_model.dart';
import 'package:flutter_application_1/services/api.dart';
import 'package:intl/intl.dart';

class Listagem extends StatefulWidget {
  const Listagem({super.key});

  @override
  State<Listagem> createState() => _ListagemState();
}

class _ListagemState extends State<Listagem> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFB3E5FC),
        body: FutureBuilder<List<Hotel>>(
          future: Api.getPets(),
          builder: (context, snapshot) {
            // se não teve resposta da api, coloca um icone de carregar
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<Hotel> dadospets = snapshot.data!;
              if (dadospets.isEmpty) {
                return const Center(child:
                 Text(" Nenhum pet cadastrado\n Comece o cadastro na tela anterior",style: 
                 TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300
                  ),));
              }
              return ListView.builder(
                padding:  EdgeInsets.all(20),
                itemCount: dadospets.length,
                itemBuilder: (BuildContext context, int index) {
                  final pet = dadospets[index];
                  return Card(
                    elevation: 20,
                    child: Padding(
                      padding:  EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Icon(Icons.pets,
                                  color: Color.fromARGB(255, 0, 0, 0), size: 32),
                               SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  pet.nameTutor,
                                  style:  TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Api.deleta(dadospets[index].id);
                                  dadospets.removeAt(index);
                                  setState(() {});
                                },
                                icon:  Icon(Icons.delete, color: Colors.red,size: 30,),
                              ),
                            ],
                          ),
                           SizedBox(height: 8),
                          Text("Número de Contato: ${pet.contatoTutor}"),
                          Text("Espécie: ${pet.especie}"),
                          Text("Raça: ${pet.raca}"),
                          Text("Entrada: ${DateFormat('dd/MM/yyyy').format(pet.dataEntrada)}"),
                          Text(
                            "Saída: ${pet.dataSaida != null ? DateFormat('dd/MM/yyyy').format(pet.dataSaida!) : 'Sem data marcada'}",
                          ),
                           SizedBox(height: 8),
                          Text("Diárias até agora: ${pet.diariasAtuais}"),
                          Text("Valor até agora: R\$ ${pet.valorAtual.toStringAsFixed(2)}"),
                          Text("Diárias previstas: ${pet.diariasPrevistas ?? '---'}"),
                          Text("Valor previsto: ${pet.valorPrevisto != null ? 'R\$ ${pet.valorPrevisto!.toStringAsFixed(2)}' : '---'}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
