import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/hotel_model.dart';
import 'package:flutter_application_1/services/api.dart';
import 'package:intl/intl.dart';

class Listagem extends StatelessWidget {
  const Listagem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Hotel>>(
        future: Api.getPets(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Hotel> dadospets = snapshot.data!;
            return ListView.builder(
              itemCount: dadospets.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.pets),
                  title: Text("${dadospets[index].nameTutor}"),
                  subtitle: Text(
                    "Raça: ${dadospets[index].raca}\n"
                    "Entrada: ${DateFormat('dd/MM/yyyy').format(dadospets[index].dataEntrada!)}\n"
                    "Saída: ${dadospets[index].dataSaida != null ? DateFormat('dd/MM/yyyy').format(dadospets[index].dataSaida!) : 'Ainda hospedado'}",
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
