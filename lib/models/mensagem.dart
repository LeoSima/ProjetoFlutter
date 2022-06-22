import 'package:flutterchat/models/user.dart';
import 'package:intl/intl.dart';

class Mensagem {
  final String corpoMensagem;
  final User userEscritor;
  final User userRecebedor;
  late DateTime dataEnvio = DateTime.now();
  late String dataFormatada = DateFormat('dMy').format(dataEnvio);
  late String horaFormatada = DateFormat('Hm').format(dataEnvio);

  Mensagem({
    required this.corpoMensagem,
    required this.userEscritor,
    required this.userRecebedor,
  });

}
