import 'package:flutter/material.dart';
import 'package:ze_menu/carrinho.dart';
import 'package:ze_menu/codigo_qr.dart';
import 'package:ze_menu/leitor.dart';
import 'package:ze_menu/pedido.dart';
import 'package:ze_menu/newPedido.dart';
import 'conexao.dart';

void main() async {
  runApp(const MyApp());
  Conexao conn = Conexao();
  conn.conectar();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZeMenu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF14C871)),
        useMaterial3: true,
      ),
      home: QRLeitor(),
      routes: {
        '/inicio': (_) => const TelaInicial(),
        '/carrinho': (_) => const Carrinho(),
        '/pedidos': (_) => const Pedidos(),
        '/newPedido': (_) => const NewPedido(),
        '/codigo': (_) => QRLeitor(),
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
  var selectedCategory = 'refeicoes';

  static CodigoQr? codigo;
  final Map<String, List<Map<String, String>>> produtos = {};
  bool isLoading = true;
  bool jaTentouConexao = false;

  @override
  void initState() {
    super.initState();
    jaTentouConexao = false;
  }

  Future<void> fetchProductsByCategory(String category) async {
    setState(() {
      isLoading = true; // Start loading indicator
    });

    Conexao conexao = Conexao(); // Create the connection instance
    TelaInicialState.codigo ??= ModalRoute.of(context)!.settings.arguments as CodigoQr;
    try {
      var result = await conexao.getProductByCategory(codigo!.restaurante, category);

      setState(() {
        produtos[category] = result[category] ?? [];
        isLoading = false; // Stop loading indicator
      });

    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false; // Stop loading indicator even in case of error
      });
    }
  }

    @override
  Widget build(BuildContext context) {
    if (!jaTentouConexao)
    {
      fetchProductsByCategory(selectedCategory);
      jaTentouConexao = true;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF14C871),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    title: 'Refeições',
                    isSelected: selectedCategory == 'refeicoes',
                    onTap: () {
                      setState(() {
                        selectedCategory = 'refeicoes';
                      });
                      fetchProductsByCategory(selectedCategory);
                    },
                  ),
                  CategoryButton(
                    title: 'Porções',
                    isSelected: selectedCategory == 'porcoes',
                    onTap: () {
                      setState(() {
                        selectedCategory = 'porcoes';
                      });
                      fetchProductsByCategory(selectedCategory);
                    },
                  ),
                  CategoryButton(
                    title: 'Bebidas não Alcoólicas',
                    isSelected: selectedCategory == 'bebidas_n_alcoolicas',
                    onTap: () {
                      setState(() {
                        selectedCategory = 'bebidas_n_alcoolicas';
                      });
                      fetchProductsByCategory(selectedCategory);
                    },
                  ),
                  CategoryButton(
                    title: 'Bebidas Alcoólicas',
                    isSelected: selectedCategory == 'bebidas_alcoolicas',
                    onTap: () {
                      setState(() {
                        selectedCategory = 'bebidas_alcoolicas';
                      });
                      fetchProductsByCategory(selectedCategory);
                    },
                  ),
                  CategoryButton(
                    title: 'Sobremesas',
                    isSelected: selectedCategory == 'sobremesas',
                    onTap: () {
                      setState(() {
                        selectedCategory = 'sobremesas';
                      });
                      fetchProductsByCategory(selectedCategory);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : produtos[selectedCategory] != null
            ? ListView(
              children: produtos[selectedCategory]!.map((produto) {
                return ProductCard(
                  title: produto['title']!,
                  description: produto['description']!,
                  price: produto['price']!,
                  imageUrl: produto['imageUrl']!,
                );
              }).toList(),
            )
            : const Center(child: Text('No products available')),
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

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  final double imageWidth;
  final double imageHeight;

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
    final screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.3;
    double imageHeight = imageWidth;
    double titleTextSize = screenWidth > 600 ? 18 : 16;
    double descriptionTextSize = screenWidth > 600 ? 14 : 12;
    double priceTextSize = screenWidth > 600 ? 18 : 16;

    return InkWell(
      onTap: () {
        // Redirect to /carrinho and pass product details
        Navigator.pushNamed(
          context,
          '/newPedido',
          arguments: {
            'title': title,
            'price': price,
            'imageUrl': imageUrl,
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    imageUrl,
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: titleTextSize,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.5,
                          child: Text(
                            description,
                            style: TextStyle(fontSize: descriptionTextSize),
                          ),
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: priceTextSize,
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
