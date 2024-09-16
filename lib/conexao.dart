import 'package:postgres/postgres.dart';
import 'package:logger/logger.dart';

class Conexao {
  late PostgreSQLConnection _connection;
  final Logger _logger = Logger();

  Conexao() {
    _connection = PostgreSQLConnection(
      'damnably-literary-tiger.data-1.use1.tembo.io',
      5432,
      'zemenu',
      username: 'postgres',
      password: 'WCw72vrvvoUFw8qs',
    );
  }

  Future<void> conectar() async {
    try {
      await _connection.open();
      _logger.i('Conectado ao banco de dados PostgreSQL');
    } catch (e) {
      _logger.e('Erro ao conectar ao banco de dados', e);
    }
  }

  Future<void> desconectar() async {
    try {
      await _connection.close();
      _logger.i('Desconectado do banco de dados PostgreSQL');
    } catch (e) {
      _logger.e('Erro ao desconectar do banco de dados', e);
    }
  }

  PostgreSQLConnection get conexao => _connection;
}
