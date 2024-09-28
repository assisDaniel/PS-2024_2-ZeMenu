import 'package:flutter/material.dart';
import 'newPedido.dart';
import 'conexao.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  // delete dos itens do carrinho
  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // Função de alerta para confirmar delete
  Future<void> _confirmDelete(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: const Text(
            'Tem certeza que deseja excluir este item?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal sem deletar
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFF44336),
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Excluir'),
              onPressed: () {
                _removeItem(index); // Chama a função de delete
                Navigator.of(context).pop(); // Fecha o modal
              },
            ),
          ],
        );
      },
    );
  }

  // função para finalizar pedidos(encaminha para /pedidos)
 Future<void> _confirmarPedido() async {
    Conexao conn = Conexao();
    await conn.conectar();
    
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          content: const Text(
            'Deseja confirmar o pedido?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 218, 0, 0),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF14C871),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Confirmar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal                
             
               for (var item in cartItems) {
                Map<String, dynamic> pedido = {
                  'nome_item': item['title'],       
                  'preco': item['price'],           
                  'imagem_item': item['imageUrl'],  
                  'qtd': item['qtd'],               
                };                
                conn.inserirPedido(pedido);
              } 
                cartItems.clear();
                // Navega para a tela de pedidos e finaliza o pedido          
                Navigator.pushNamed(
                  context,
                  '/pedidos',
                  //arguments: cartItems, // Envia os itens do carrinho
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color(0xFF14C871),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: cartItems.isEmpty
                  ? const Center(
                      child: Text('Carrinho vazio'),
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (ctx, index) {
                        final product = cartItems[index];
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(234, 236, 237, 237),
                              borderRadius: BorderRadius.circular(5)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  product['imageUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              product['title'],
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              'Quantidade: ${product['qtd']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'R\$${product['total']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Transform.translate(
                                  offset: const Offset(20, 0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      _confirmDelete(index);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF14C871),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    /*
                    Navigator.pushNamed(
                      context,
                      '/pedidos',
                      arguments: cartItems,
                    );
                    */
                    _confirmarPedido();
                  },
                  child: const Text(
                    'Finalizar pedido',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
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
