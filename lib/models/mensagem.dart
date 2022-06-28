import 'package:flutterchat/models/user.dart';
import 'package:intl/intl.dart';

class Mensagem {
  final String corpoMensagem;
  final User userEscritor;
  final User userRecebedor;
  late DateTime dataEnvio = DateTime.now();
  late String diaEnvio = validaDia(DateFormat('d').format(dataEnvio));
  late String mesEnvio = validaMes(DateFormat('M').format(dataEnvio));
  late String anoEnvio = DateFormat('y').format(dataEnvio);
  late String horaFormatada = DateFormat('Hm').format(dataEnvio);
  late String dataFormatada = ("$diaEnvio/$mesEnvio/$anoEnvio $horaFormatada");

  Mensagem({
    required this.corpoMensagem,
    required this.userEscritor,
    required this.userRecebedor,
  });

  validaDia(String dia) {
    if (dia.length == 1) return "0$dia";
    return dia;
  }

  validaMes(String mes) {
    if (mes.length == 1) return "0$mes";
    return mes;
  }
}
