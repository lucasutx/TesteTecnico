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
        backgroundColor: const Color(0xFFF5F5F5),
        body: FutureBuilder<List<Hotel>>(
          future: Api.getPets(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<Hotel> dadospets = snapshot.data!;
              if (dadospets.isEmpty) {
                return const Center(child: Text("Nenhum pet cadastrado."));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: dadospets.length,
                itemBuilder: (BuildContext context, int index) {
                  final pet = dadospets[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.pets,
                                  color: Colors.blueGrey, size: 32),
                              const SizedBox(width: 10),
                              Text(
                                pet.nameTutor ?? 'Sem nome',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Api.deleta(dadospets[index].id);
                                  dadospets.removeAt(index);
                                  
                                  setState(() {
                                    
                                  });
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text("Contato: ${pet.contatoTutor ?? '---'}"),
                          Text("Espécie: ${pet.especie ?? '---'}"),
                          Text("Raça: ${pet.raca ?? '---'}"),
                          Text(
                              "Entrada: ${DateFormat('dd/MM/yyyy').format(pet.dataEntrada!)}"),
                          Text(
                              "Saída: ${pet.dataSaida != null ? DateFormat('dd/MM/yyyy').format(pet.dataSaida!) : 'Ainda hospedado'}"),
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