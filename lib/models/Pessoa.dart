class Pessoa {
  final id;
  final cpf;
  final name;
  final email;
  final telefone;
  final dt_nasc;
  final sexo;
  final tipo;
  final id_empresa;

  Pessoa({
    this.id,
    this.cpf,
    this.name,
    this.email,
    this.telefone,
    this.dt_nasc,
    this.sexo,
    this.tipo,
    this.id_empresa,
  });

  factory Pessoa.fromJson(Map<String, dynamic> json){
    return Pessoa(
      id: json['id'],
      cpf: json['cpf'],
      name: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      id_empresa: json['id_empresa'],
      dt_nasc: json['dt_nasc'],
      sexo: json['sexo'],
      tipo: json['tipo'],
    );
  }
}