import 'package:postgres/postgres.dart';

class Conexao{
  PostgreSQLConnection? conn;

  Conexao();

  Future conectar() async {
    conn = PostgreSQLConnection(
      "damnably-literary-tiger.data-1.use1.tembo.io", 5432, "postgres",
      username: "postgres",
      password: "WCw72vrvvoUFw8qs",
      useSSL: true);
    try {
      await conn!.open();
      print("Connected");
    }catch(e) {
      print("error");
      print(e.toString());
    }
  }


  Future<Map<String, List<Map<String, String>>>> getProductByCategory(String categoria) async {
    if (conn == null || conn!.isClosed) {
      await conectar();
    }

    try {
      List<List<dynamic>> results = await conn!.query('''
        SELECT nome_item, descricao, precos::numeric, imagem_item 
        FROM emp1.cardapio 
        WHERE categoria = @categoria
      ''', substitutionValues: {
        'categoria': categoria
      });

      if (results.isEmpty) {
        print("No products found for category: $categoria");
        return {};
      }

      Map<String, List<Map<String, String>>> produtos = {categoria: []};

      for (var row in results){
        produtos[categoria]?.add({
          'title': row[0].toString(),
          'description': row[1].toString(),
          'price': 'R\$ '+row[2].toString(),
          'imageUrl': row[3].toString()
        });
      }

      return produtos;
    } catch (e) {
      print("Error retrieving products: ${e.toString()}");
      return {};
    }
  }
}