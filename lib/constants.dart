import 'package:flutter/material.dart';
import 'package:emprega_unitins/size_config.dart';

const kPrimaryColor = Color(0xFF1A237E);
const kPrimaryLightColor = Color(0xFF7986CB);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF7986CB), Color(0xFF1A237E)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const caminho = "http://192.168.137.1:8090/api/";

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

final RegExp cpfValidator = RegExp(r"^[0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2}");
final RegExp cnpjValidator = RegExp(r"^[0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2}");
final RegExp dtValidator = RegExp(r"^[0-9]{2}[\/]?[0-9]{2}[\/]?[0-9]{4}");

const String kEmailNullError = "Por favor informe o email";
const String kInvalidEmailError = "Entre com um email válido";

const String kCPFNullError = "Por favor informe o CPF";
const String kInvalidCPFError = "Entre com um CPF válido";

const String kCNPJNullError = "Por favor informe o CNPJ";
const String kInvalidCNPJError = "Entre com um CNPJ válido";

const String kDtNascNullError = "Por favor informe a data de nascimento";
const String kInvalidDtNascError = "Por favor informe uma data de nascimento válida";

const String kDtIniNullError = "Por favor informe a data de início";
const String kInvalidDtIniError = "Por favor informe uma data de início válida";

const String kDtFimNullError = "Por favor informe a data final";
const String kInvalidDtFimError = "Por favor informe uma data final válida";

const String kSexoNullError = "Por favor informe o sexo";

const String kPassNullError = "Por favor informe a senha";
const String kShortPassError = "Senha muito curta";
const String kMatchPassError = "Senhas não conferem";

const String kNameNullError = "Por favor informe o nome";

const String kEmpresaNullError = "Por favor informe a empresa";

const String kRazaoSocialNullError = "Por favor informe a razão social";

const String kNomeFantasiaNullError = "Por favor informe o nome fantasia";

const String kCargoNullError = "Por favor informe o cargo";

const String kCursoNullError = "Por favor informe o curso";

const String kInstNullError = "Por favor informe a instituição";

const String kNivelNullError = "Por favor informe o nível";

const String kHabNullError = "Por favor informe a habilidade";

const String kPhoneNumberNullError = "Por favor informe o telefone";

const String kAddressNullError = "Por favor informe o endereço";

const String kUFNullError = "Por favor informe a UF";

const String kCidadeNullError = "Por favor informe a cidade";

const String kBairroNullError = "Por favor informe o bairro";

const String kNumeroNullError = "Por favor informe o número";

const String kRuaNullError = "Por favor informe a rua";

const String kResumoNullError = "Por favor informe o resumo";

const String kHorarioNullError = "Por favor informe o horário";


final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
