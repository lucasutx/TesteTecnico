import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'http://192.168.1.3:2000/';

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
}

