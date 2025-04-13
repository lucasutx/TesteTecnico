import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'http://192.168.1.103/api/';

  static Future<void> add(Map dados) async {
    print(dados);

    final url = Uri.parse("${baseUrl}add");

    try {

      final res = await http.post(
        url,
        body: jsonEncode(dados),
      );

      if (res.statusCode == 201 || res.statusCode == 200) {
        var resposta = jsonDecode(res.body);
        debugPrint("Pet cadastrado com sucesso: $resposta");
      } else {
        debugPrint("Erro ao cadastrar pet: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Erro na requisição: $e");
    }
  }
}
