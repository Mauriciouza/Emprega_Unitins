class Endereco {
  final id;
  final id_empresa;
  final bairro;
  final rua;
  final numero;
  final complemento;
  final cidade;
  final UF;

  Endereco({
    this.id,
    this.id_empresa,
    this.bairro,
    this.rua,
    this.numero,
    this.complemento,
    this.cidade,
    this.UF,
  });

  factory Endereco.fromJson(Map<String, dynamic> json){
    return Endereco(
      id: json['id'],
      id_empresa: json['id_empresa'],
      bairro: json['bairro'],
      rua: json['rua'],
      numero: json['numero'],
      complemento: json['complemento'],
      cidade: json['cidade'],
      UF: json['UF'],
    );
  }
}