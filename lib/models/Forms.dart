class Forms{
  final  id;
  final  curso;
  final  nivel;
  final  dt_inicio;
  final  dt_fim;
  final  id_pessoa;
  final  instituicao;

  Forms({
    this.id,
    this.curso,
    this.nivel,
    this.dt_inicio,
    this.dt_fim,
    this.id_pessoa,
    this.instituicao,
  });

  factory Forms.fromJson(Map<String, dynamic> json){
    return Forms(
      id: json['id'],
      curso: json['curso'],
      nivel: json['nivel'],
      dt_inicio: json['dt_inicio'],
      dt_fim: json['dt_fim'],
      id_pessoa: json['id_pessoa'],
      instituicao: json['instituicao'],
    );
  }
}