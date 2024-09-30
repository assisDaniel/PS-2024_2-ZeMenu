import 'package:flutter/material.dart';

// Lista de itens para o carrinho
List<Map<String, dynamic>> cartItems = [];

class NewPedido extends StatefulWidget {
  const NewPedido({super.key});

  @override
  State<NewPedido> createState() => _NewPedidoState();
}

class _NewPedidoState extends State<NewPedido> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from the previous screen
    final product =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (product == null) {
      return const Scaffold(
        body: Center(child: Text("No product selected")),
      );
    }

    // Parse the price to a double to handle calculations
    double price = double.parse(
        product['price']!.replaceAll('R\$', '').replaceAll(',', '.'));

    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Product Image and Details
            Row(
              children: [
                Image.asset(
                  product['imageUrl']!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['title']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${product['price']}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),

            // Order Summary Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumo do pedido',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantidade',
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              });
                            },
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Total Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'R\$ ${(price * quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Add to Cart Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF14C871),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                // Adiciona os itens na lista do carrinho
                cartItems.add({
                  'title': product['title'],
                  'price': product['price'],
                  'imageUrl': product['imageUrl'],
                  'qtd': quantity,
                  'total': price * quantity,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('${product['title']} adicionado ao carrinho!')),
                );
                Navigator.pop(context); // Volta para a tela de inicio
              },
              child: const Text(
                'Adicionar ao carrinho',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamed('/incio');
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
