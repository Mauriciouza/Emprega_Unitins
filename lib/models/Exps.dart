class Exps{
  final  id;
  final  cargo;
  final  empresa;
  final  dt_inicio;
  final  dt_fim;
  final  id_pessoa;

  Exps({
    this.id,
    this.cargo,
    this.empresa,
    this.dt_inicio,
    this.dt_fim,
    this.id_pessoa
  });

  factory Exps.fromJson(Map<String, dynamic> json){
    return Exps(
      id: json['id'],
      cargo: json['cargo'],
      empresa: json['empresa'],
      dt_inicio: json['dt_inicio'],
      dt_fim: json['dt_fim'],
      id_pessoa: json['id_pessoa'],
    );
  }
}