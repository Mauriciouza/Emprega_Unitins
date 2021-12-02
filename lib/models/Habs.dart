class Habs{
  final  id;
  final  habilidade;
  final  nivel;
  final  id_pessoa;

  Habs({
    this.id,
    this.habilidade,
    this.nivel,
    this.id_pessoa,
  });

  factory Habs.fromJson(Map<String, dynamic> json){
    return Habs(
      id: json['id'],
      habilidade: json['habilidade'],
      nivel: json['nivel'],
      id_pessoa: json['id_pessoa'],
    );
  }
}