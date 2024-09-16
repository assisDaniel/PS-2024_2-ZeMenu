import 'package:flutter/material.dart';
import 'package:ze_menu/carrinho.dart';
import 'package:ze_menu/pedido.dart';
import 'conexao.dart';

void main() async {
  runApp(const MyApp());
  Conexao conexao = Conexao();
  await conexao.conectar();
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
      routes: {
        '/incio': (_) => const MyApp(),
        '/carrinho': (_) => const Carrinho(),
        '/pedidos': (_) => const Pedidos(),
      },
    );
  }
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  TelaInicialState createState() => TelaInicialState();
}

class TelaInicialState extends State<TelaInicial> {
  String selectedCategory = 'Lanches';

  final Map<String, List<Map<String, String>>> products = {
    'Lanches': [
      {
        'title': 'X Tudo',
        'description':
            'PÃO, HAMBURGUER, BACON, SALSICHA, CALABRESA, OVO, CATUPIRY, PRESUNTO, MUSSARELA, ALFACE, TOMATE.',
        'price': 'R\$ 25,00',
        'imageUrl': 'assets/images/fotohamburguer.png',
      },
      {
        'title': 'X Bacon',
        'description':
            'PÃO, HAMBURGUER, BACON, SALSICHA, OVO, CATUPIRY, PRESUNTO, MUSSARELA, ALFACE, TOMATE.',
        'price': 'R\$ 21,00',
        'imageUrl': 'assets/images/fotohamburguer.png',
      },
    ],
    'Sucos': [
      {
        'title': 'Suco de Laranja',
        'description': 'Fresco, natural e delicioso.',
        'price': 'R\$ 10,00',
        'imageUrl': 'assets/images/suco_laranja.jpg',
      },
      {
        'title': 'Suco de Morango',
        'description': 'Refrescante e doce.',
        'price': 'R\$ 12,00',
        'imageUrl': 'assets/images/suco_morango.png',
      },
    ],
    'Refrigerantes': [
      {
        'title': 'Coca-Cola',
        'description': 'Tradicional e gelada.',
        'price': 'R\$ 7,00',
        'imageUrl': 'assets/images/coca_cola.png',
      },
      {
        'title': 'Guaraná',
        'description': 'Brasileiro e refrescante.',
        'price': 'R\$ 6,00',
        'imageUrl': 'assets/images/guarana.jpg',
      },
    ],
    'Cremes': [
      {
        'title': 'Açaí',
        'description': 'Açaí cremoso com acompanhamentos.',
        'price': 'R\$ 15,00',
        'imageUrl': 'assets/images/acai.png',
      },
      {
        'title': 'Creme de Cupuaçu',
        'description': 'Sabor único e tropical.',
        'price': 'R\$ 13,00',
        'imageUrl': 'assets/images/cupuacu.png',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14C871),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'O que você deseja hoje?',
                    prefixIcon: const ImageIcon(
                      AssetImage("assets/images/busca.png"),
                      color: Color.fromARGB(255, 102, 102, 102),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logoempresa.png',
                      height: 64,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryButton(
                    title: 'Lanches',
                    isSelected: selectedCategory == 'Lanches',
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Lanches';
                      });
                    },
                  ),
                  CategoryButton(
                    title: 'Sucos',
                    isSelected: selectedCategory == 'Sucos',
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Sucos';
                      });
                    },
                  ),
                  CategoryButton(
                    title: 'Refrigerantes',
                    isSelected: selectedCategory == 'Refrigerantes',
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Refrigerantes';
                      });
                    },
                  ),
                  CategoryButton(
                    title: 'Cremes',
                    isSelected: selectedCategory == 'Cremes',
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Cremes';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: ListView(
              children: products[selectedCategory]!.map((product) {
                return ProductCard(
                  title: product['title']!,
                  description: product['description']!,
                  price: product['price']!,
                  imageUrl: product['imageUrl']!,
                );
              }).toList(),
            ),
          ),
        ],
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

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  final double imageWidth; // Largura da imagem
  final double imageHeight; // Altura da imagem

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.imageWidth = 100,
    this.imageHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    // Obtém o tamanho da tela
    final screenWidth = MediaQuery.of(context).size.width;

    // Defina diferentes larguras para a imagem conforme o tamanho da tela
    double imageWidth = screenWidth * 0.3;
    double imageHeight = imageWidth;

    // Modifica os tamanhos de texto de forma responsiva
    double titleTextSize = screenWidth > 600 ? 18 : 16; // Aumenta em telas maiores
    double descriptionTextSize = screenWidth > 600 ? 14 : 12;
    double priceTextSize = screenWidth > 600 ? 18 : 16;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Ajustar layout responsivo com base na largura disponível
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imageUrl,
                  width: imageWidth, // Define a largura responsiva da imagem
                  height: imageHeight, // Define a altura responsiva da imagem
                  fit: BoxFit.cover, // A imagem preenche o container
                ),
                const SizedBox(width: 12),
                Expanded(
                  // Expande o conteúdo da descrição para ocupar o restante do espaço
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleTextSize, // Tamanho responsivo
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.5, // Responsivo ao tamanho da tela
                        child: Text(
                          description,
                          style: TextStyle(fontSize: descriptionTextSize),
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: priceTextSize, // Tamanho responsivo
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFF14C871) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF14C871),
          ),
        ),
      ),
    );
  }
}
