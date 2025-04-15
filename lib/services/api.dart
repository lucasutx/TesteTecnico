import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/hotel_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'http://192.168.1.3:2000/';

  //Adiciona
static Future<void> add(Map dados) async {
    final url = Uri.parse("${baseUrl}pets");

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dados),
      );

      if (res.statusCode == 201 || res.statusCode == 200) {
        debugPrint("Pet cadastrado com sucesso: ${res.body}");
      } else {
        debugPrint("Erro ao cadastrar pet: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Erro na requisição: $e");
    }
  }
  //Visualiza
static Future<List<Hotel>> getPets() async {
  final url = Uri.parse("${baseUrl}pets");

  try {
    final res = await http.get(url);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      List<Hotel> listaPets = [];

      data['pets'].forEach((value) {
        listaPets.add(
          Hotel(
            id: value['id'],
            nameTutor: value['tutorNome'],
            contatoTutor: value['tutorContato'],
            especie: value['especie'],
            raca: value['raca'],
            dataEntrada: DateTime.parse(value['dataEntrada']),
            dataSaida: value['dataSaida'] != null
                ? DateTime.tryParse(value['dataSaida'])
                : null,
          ),
        );
      });

      return listaPets;
    } else {
      debugPrint("Erro ao buscar pets: ${res.statusCode}");
      return [];
    }
  } catch (e) {
    debugPrint("Erro na requisição GET: $e");
    return [];
  }
}

  //deleta
static Future<void> deleta(id) async {
  final url = Uri.parse("${baseUrl}pets/$id");

  try {
    final res = await http.post(url);

    if (res.statusCode == 200 || res.statusCode == 204) {
      debugPrint("Pet com id $id deletado com sucesso.");
    } else {
      debugPrint("Erro ao deletar pet: ${res.statusCode}");
    }
  } catch (e) {
    debugPrint("Erro na requisição DELETE: $e");
  }
}
 
}
