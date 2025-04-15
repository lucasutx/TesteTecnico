class Hotel {
  final int? id; // <- aceita nulo
  final String nameTutor;
  final String contatoTutor;
  final String especie;
  final String raca;
  final DateTime dataEntrada;
  final DateTime? dataSaida;

  Hotel({
    this.id, // <- não é mais required
    required this.nameTutor,
    required this.contatoTutor,
    required this.especie,
    required this.raca,
    required this.dataEntrada,
    this.dataSaida,
  });
}
