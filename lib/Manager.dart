import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/Listagem.dart';

class PetHotelApp extends StatelessWidget {
  const PetHotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel para Pets',
      home: const PetListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tutorNomeController = TextEditingController();
  final _tutorContatoController = TextEditingController();
  final _racaController = TextEditingController();
  DateTime? _dataEntrada;
  DateTime? _dataSaida;
  String? _especie;

  void _abrirFormulario() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _tutorNomeController,
                    decoration:
                        const InputDecoration(labelText: 'Nome do Tutor'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe o nome'
                        : null,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions() ,
                    controller: _tutorContatoController,
                    decoration:
                        const InputDecoration(labelText: 'Contato do Tutor'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe o contato'
                        : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: _especie,
                    decoration: const InputDecoration(labelText: 'Espécie'),
                    items: const [
                      DropdownMenuItem(
                          value: 'Cachorro', child: Text('Cachorro')),
                      DropdownMenuItem(value: 'Gato', child: Text('Gato')),
                    ],
                    onChanged: (value) => setState(() => _especie = value),
                    validator: (value) =>
                        value == null ? 'Selecione uma espécie' : null,
                  ),
                  TextFormField(
                    controller: _racaController,
                    decoration: const InputDecoration(labelText: 'Raça'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe a raça'
                        : null,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _dataEntrada != null
                              ? 'Entrada: ${DateFormat('dd/MM/yyyy').format(_dataEntrada!)}'
                              : 'Data de entrada',
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final data = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2100),
                          );
                          if (data != null) {
                            setState(() => _dataEntrada = data);
                          }
                        },
                        child: const Text('Selecionar'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _dataSaida != null
                              ? 'Saída: ${DateFormat('dd/MM/yyyy').format(_dataSaida!)}'
                              : 'Previsão de saída',
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final data = await showDatePicker(
                            context: context,
                            initialDate: _dataEntrada ?? DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2100),
                          );
                          if (data != null) {
                            setState(() => _dataSaida = data);
                          }
                        },
                        child: const Text('Selecionar'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                        
                      if (_formKey.currentState!.validate() &&
                          _dataEntrada != null) {
                            
                        final Map<String, dynamic> novoPet = {
                          'tutorNome': _tutorNomeController.text,
                          'tutorContato': _tutorContatoController.text,
                          'especie': _especie,
                          'raca': _racaController.text,
                          'dataEntrada': _dataEntrada!.toIso8601String(),
                          'dataSaida': _dataSaida?.toIso8601String(),
                        };
                        await Api.add(novoPet);
                        _limparCampos();
                        setState(() {});
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _limparCampos() {
    _tutorNomeController.clear();
    _tutorContatoController.clear();
    _racaController.clear();
    _especie = null;
    _dataEntrada = null;
    _dataSaida = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Controle de Hospedagem de Pets",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 40),
                Icon(
                  Icons.pets,
                  size: 120,
                  color: Colors.blueGrey,
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormulario,
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
