class Empresa {
  final id;
  final cnpj;
  final nome_fantasia;
  final razao_social;
  final telefone;
  final email;

  Empresa({
    this.id,
    this.cnpj,
    this.nome_fantasia,
    this.razao_social,
    this.telefone,
    this.email,
  });

  factory Empresa.fromJson(Map<String, dynamic> json){
    return Empresa(
      id: json['id'],
      cnpj: json['cnpj'],
      nome_fantasia: json['nome_fantasia'],
      razao_social: json['razao_social'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }
}