class Vaga{
  final  id;
  final  cargo;
  final  horario;
  final  resumo;
  final  habilidades;
  final  id_empresa;
  final  id_pessoa;
  final  status;

  Vaga({
    this.id,
    this.cargo,
    this.horario,
    this.resumo,
    this.habilidades,
    this.id_empresa,
    this.id_pessoa,
    this.status
  });

  factory Vaga.fromJson(Map<String, dynamic> json){
    return Vaga(
      id: json['id'],
      cargo: json['cargo'],
      horario: json['horario'],
      resumo: json['resumo'],
      habilidades: json['habilidades'],
      id_empresa: json['id_empresa'],
      id_pessoa: json['id_pessoa'],
      status: json['status'],
    );
  }
}