class Hotel {
  final int? id; 
  final String nameTutor;
  final String contatoTutor;
  final String especie;
  final String raca;
  final DateTime dataEntrada;
  final DateTime? dataSaida;

  Hotel({
    this.id, 
    required this.nameTutor,
    required this.contatoTutor,
    required this.especie,
    required this.raca,
    required this.dataEntrada,
    this.dataSaida,
  });
  
   
  int get diariasAtuais {
    final hoje = DateTime.now();
    final inicio = dataEntrada;
    final fim = dataSaida ?? hoje;
    return fim.difference(inicio).inDays + 1;
  }

  int? get diariasPrevistas {
    if (dataSaida == null) return null;
    return dataSaida!.difference(dataEntrada).inDays + 1;
  }

  double get valorAtual {
    return diariasAtuais * 50.0;
  }

  double? get valorPrevisto {
    final previstas = diariasPrevistas;
    if (previstas == null) return null;
    return previstas * 50.0;
  }

}
