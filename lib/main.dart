import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZeMenu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF14C871)),
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14C871), // Cor verde definida
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.vertical(
            bottom:  Radius.circular(30)
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(90.0), // Altura da barra inferior
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'O que você deseja hoje?',
                    prefixIcon: const ImageIcon(
                      AssetImage(
                          "assets/images/busca.png"), // Caminho do ícone de busca
                      color: Color.fromARGB(255, 102, 102, 102),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide( color: Colors.white),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintStyle: const TextStyle( color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logoempresa.png', // Caminho da logo
                      height: 64, // Altura da logo
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Hamburgueria',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Barra de Categorias
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Permite rolagem horizontal
              child: Row(
                children: [
                  CategoryButton(title: 'Lanches'),
                  CategoryButton(title: 'Sucos'),
                  CategoryButton(title: 'Refrigerantes'),
                  CategoryButton(title: 'Cremes'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Lista de Produtos
          Expanded(
            child: ListView(
              children: const [
                ProductCard(
                  title: 'X Tudo',
                  description:
                      'PÃO, HAMBURGUER, BACON, SALSICHA, CALABRESA, OVO, CATUPIRY, PRESUNTO, MUSSARELA, ALFACE, TOMATE.',
                  price: 'R\$ 25,00',
                  imageUrl: 'assets/images/fotohamburguer.png',
                ),
                ProductCard(
                  title: 'X Bacon',
                  description:
                      'PÃO, HAMBURGUER, BACON, SALSICHA, OVO, CATUPIRY, PRESUNTO, MUSSARELA, ALFACE, TOMATE.',
                  price: 'R\$ 21,00',
                  imageUrl: 'assets/images/fotohamburguer.png',
                ),
                ProductCard(
                  title: 'X Moda da casa',
                  description:
                      'PÃO, HAMBURGUER, BACON, SALSICHA, CALABRESA, OVO, CATUPIRY, PRESUNTO, MUSSARELA, ALFACE, TOMATE.',
                  price: 'R\$ 23,00',
                  imageUrl: 'assets/images/fotohamburguer.png',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/botaoinicio.png"),
              size: 50,
            ), // Ícone de home
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/botaopedidos.png"),
              size: 50,
            ), // Ícone de lista
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/botaocarrinho.png"),
              size: 50,
            ), // Ícone de carrinho
            label: '',
          ),
        ],
        backgroundColor: const Color(0xFF14C871), // Cor de fundo verde
        selectedItemColor: Colors.white,
        unselectedItemColor:
            Colors.white54, // Cores dos ícones quando não selecionados
        showSelectedLabels: true, // Exibe os rótulos dos itens selecionados
        showUnselectedLabels:
            true, // Exibe os rótulos dos itens não selecionados
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            Image.asset(imageUrl),
            const SizedBox(width: 12), // Imagem do produto
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaler: const TextScaler.linear(1.25),
                ),
                SizedBox(
                  width: 250,
                  child: Text(description,
                    textScaler: const TextScaler.linear(0.75)
                  ),
                ),
                Text(price,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaler: const TextScaler.linear(1.25),
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;

  const CategoryButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          title,
          style:
              const TextStyle(color: Color(0xFF14C871)), // Cor verde dos textos
        ),
      ),
    );
  }
}