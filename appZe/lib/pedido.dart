import 'package:flutter/material.dart';
import 'conexao.dart'; // Sua classe de conexão

class Pedidos extends StatefulWidget {
  const Pedidos({super.key});

  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  final Conexao conexao = Conexao();
  List<Map<String, dynamic>> _produtos = [];
  bool _isLoading = true;
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _carregarPedidos();
  }

  Future<void> _carregarPedidos() async {
    setState(() {
      _isLoading = true;
    });

    // Conectar ao banco de dados se necessário
    if (conexao.conn == null || conexao.conn!.isClosed) {
      await conexao.conectar();
    }

    try {
      List<List<dynamic>> results = await conexao.conn!.query('''
        SELECT nome_item, qtd, preco, imagem_item 
        FROM emp1.pedidos 
      ''');

      List<Map<String, dynamic>> pedidos = [];
      double total = 0.0;
      for (var row in results) {
        int quantidade = int.parse(row[1].toString());
        double preco = double.parse(row[2].toString());

        pedidos.add({
          'title': row[0].toString(),
          'description': 'Quantidade: $quantidade', 
          'price': preco, 
          'imageUrl': row[3].toString(),
        });

        total += quantidade * preco;
      }

      setState(() {
        _produtos = pedidos;
        _total = total;
        _isLoading = false;
      });
    } catch (e) {
      print("Erro ao recuperar os pedidos: ${e.toString()}");

      setState(() {
        _produtos = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itens Pedidos'),
        backgroundColor: const Color(0xFF14C871), // Cor de fundo da AppBar
        foregroundColor: Colors.white, // Cor do título (texto) em branco
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _produtos.isEmpty
                      ? const Center(child: Text('Nenhum pedido disponível'))
                      : ListView.builder(
                          itemCount: _produtos.length,
                          itemBuilder: (context, index) {
                            final produto = _produtos[index];
                            return ListTile(
                              leading: Image.asset(
                                produto['imageUrl'] ?? 'assets/images/placeholder.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image_not_supported, size: 50);
                                },
                              ),
                              title: Text(produto['title'] ?? ''),
                              subtitle: Text(produto['description'] ?? ''),
                              trailing: Text('R\$ ${produto['price'].toString()}'),
                            );
                          },
                        ),
                ),
                Container(
                  color: const Color(0xFFEFEFEF), // Cor do fundo cinza claro
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resumo da compra',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'R\$ ${_total.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'R\$ ${_total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed('/inicio');
              break;
            case 1:
              Navigator.of(context).pushNamed('/pedidos');
              break;
            case 2:
              Navigator.of(context).pushNamed('/carrinho');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/botaoinicio.png"),
              size: 50,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/botaopedidos.png"),
              size: 50,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/botaocarrinho.png"),
              size: 50,
            ),
            label: '',
          ),
        ],
        backgroundColor: const Color(0xFF14C871),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
